{ lib, config, ... }:
let
  cfg = config.modules.impermanence;
in
{
  config = lib.mkIf (cfg.enable && (cfg.type == "btrfs")) {
    modules.impermanence.disko-devices = {
      disk = {
        "root-impermanence" = {
          # type = "disk";
          content = {
            #type = "gpt";
            partitions = {
              "btrfs-root" = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "--force" # Override existing partition
                    "--checksum blake2b" # stronger than crc32c and xxhash, faster than sha256
                  ];
                  subvolumes =
                    {
                      "/rootfs" = {
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                          "ssd"
                        ];
                        mountpoint = "/";
                      };
                      "/nix" = {
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                          "ssd"
                        ];
                        mountpoint = "/nix";
                      };
                      "/persist" = {
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                          "ssd"
                        ];
                        mountpoint = "/mnt/persist";
                      };
                    }
                    // lib.mergeAttrsList (
                      builtins.map (volume: {
                        "/${volume}" = {
                          mountOptions = [
                            "compress=zstd"
                            "noatime"
                            "ssd"
                          ];
                          mountpoint = "/mnt/${volume}";
                        };
                      }) cfg.extraVolumes
                    );
                };
              };
            };
          };
        };
      };
    };

    boot.initrd.systemd.services."rollback-btrfs-rootfs" = {
      description = "Rollback BTRFS rootfs to a pristine state";
      wantedBy = [ "initrd.target" ];
      after = [
        "initrd-root-device.target"
        "dev-disk-by\x2dpartlabel-disk\x2droot\x2dimpermanence\x2dbtrfs\x2droot.device"
      ];
      requires = [ "initrd-root-device.target" ];
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script =
        let
          disk = config.disko.devices.disk."root-impermanence";
        in
        ''
          mkdir -p /mnt_btrfs
          # We first mount the btrfs root to /mnt_btrfs
          # so we can manipulate btrfs subvolumes.
          mount -t btrfs -o subvol=/ ${disk.device}-part${
            toString disk.content.partitions."btrfs-root"._index
          } /mnt_btrfs
          # While we're tempted to just delete /rootfs and create
          # a new snapshot from /root-blank, /rootfs is already
          # populated at this point with a number of subvolumes,
          # which makes `btrfs subvolume delete` fail.
          # So, we remove them first.
          #
          # /rootfs contains subvolumes:
          # - /rootfs/var/lib/portables
          # - /rootfs/var/lib/machines
          #
          # I suspect these are related to systemd-nspawn, but
          # since I don't use it I'm not 100% sure.
          # Anyhow, deleting these subvolumes hasn't resulted
          # in any issues so far, except for fairly
          # benign-looking errors from systemd-tmpfiles.
          btrfs subvolume list -o /mnt_btrfs/rootfs |
            cut -f9 -d' ' |
            while read subvolume; do
              echo "deleting /$subvolume subvolume..."
              btrfs subvolume delete "/mnt_btrfs/$subvolume"
            done &&
            echo "deleting /rootfs subvolume..." &&
            btrfs subvolume delete /mnt_btrfs/rootfs
          echo "creating blank /rootfs subvolume..."
          btrfs subvolume create /mnt_btrfs/rootfs
          # Once we're done rolling back to a blank snapshot,
          # we can unmount /mnt_btrfs and continue on the boot process.
          umount /mnt_btrfs
        '';
    };
  };
}
