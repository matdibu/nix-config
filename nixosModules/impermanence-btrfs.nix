{ lib, config, ... }:
let
  cfg = config.modules.impermanence-btrfs;
in
{
  options.modules.impermanence-btrfs = {
    enable = lib.mkEnableOption "impermanence";
    device = lib.mkOption {
      type = lib.types.str;
      default = null;
    };
    mountpoint = lib.mkOption {
      type = lib.types.str;
      default = "/mnt/persist";
    };
  };

  config = lib.mkIf cfg.enable {
    # Don't allow mutation of users outside of the config.
    users.mutableUsers = false;

    boot.initrd.supportedFilesystems = [ "btrfs" ]; # boot from btrfs
    boot.supportedFilesystems = [ "btrfs" ]; # boot from btrfs

    fileSystems.${cfg.mountpoint}.neededForBoot = true;

    environment.persistence.${cfg.mountpoint} = {
      hideMounts = true;
      files = lib.mkMerge [
        (lib.mkIf config.services.openssh.enable [
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_rsa_key"
        ])
        [ "/etc/machine-id" ]
      ];
      directories = [
        "/var/log"
        # "/var/lib/systemd/coredump"
      ];
    };

    fileSystems."/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "size=25%"
        "mode=755"
        "nosuid"
      ];
    };

    disko.devices = {
      disk = {
        "root-impermanence" = {
          inherit (cfg) device;
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                size = "500M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  extraArgs = [ "-F32" ];
                  mountpoint = "/boot";
                  mountOptions = [
                    "fmask=0137"
                    "dmask=0027"
                    "noatime"
                  ];
                };
              };
              btrfs-root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ]; # Override existing partition
                  subvolumes = {
                    "/nix" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "checksum=sha256"
                      ];
                      mountpoint = "/nix";
                    };
                    "/persist" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        "checksum=blake2b"
                      ];
                      inherit (cfg) mountpoint;
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
