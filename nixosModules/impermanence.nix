{ inputs
, lib
, config
, pkgs
, ...
}:
let
  cfg = config.modules.impermanence;
in
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.disko.nixosModules.default
  ];
  options.modules.impermanence = {
    enable = lib.mkEnableOption "impermanence";
    device = lib.mkOption {
      type = lib.types.str;
      default = null;
    };
    mountpoint = lib.mkOption {
      type = lib.types.str;
      default = "/mnt/persist";
    };
    poolName = lib.mkOption {
      type = lib.types.str;
      default = "tank";
    };
  };

  config = lib.mkIf cfg.enable (
    let
      snapshotName = "${cfg.poolName}/system/root@blank";
    in
    {
      # Don't allow mutation of users outside of the config.
      users.mutableUsers = false;

      boot = {
        initrd.supportedFilesystems = [ "zfs" ]; # boot from zfs
        zfs.extraPools = [ "${cfg.poolName}" ];
      };

      fileSystems.${cfg.mountpoint}.neededForBoot = true;

      environment.persistence.${cfg.mountpoint} = {
        hideMounts = true;
        files = lib.mkMerge [
          (lib.mkIf config.services.openssh.enable [
            "/etc/ssh/ssh_host_ed25519_key"
            "/etc/ssh/ssh_host_rsa_key"
          ])
          [
            "/etc/machine-id"
          ]
        ];
        directories = [
          "/var/log"
          # "/var/lib/systemd/coredump"
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
                  size = "500M";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [
                      "fmask=0137"
                      "dmask=0027"
                      "noatime"
                    ];
                  };
                };
                zfs = {
                  size = "100%";
                  content = {
                    type = "zfs";
                    pool = cfg.poolName;
                  };
                };
              };
            };
          };
        };
        zpool = {
          ${cfg.poolName} = {
            type = "zpool";
            options = {
              ashift = "12";
              autotrim = "on";
            };
            rootFsOptions = {
              compression = "lz4";
              "com.sun:auto-snapshot" = "false";
              atime = "off";
              xattr = "sa";
              acltype = "posixacl";
            };
            postCreateHook = "zfs snapshot ${snapshotName}";
            datasets = {
              "system" = {
                type = "zfs_fs";
              };
              "system/nix" = {
                type = "zfs_fs";
                mountpoint = "/nix";
              };
              "system/root" = {
                type = "zfs_fs";
                mountpoint = "/";
              };
              "system/persist" = {
                type = "zfs_fs";
                inherit (cfg) mountpoint;
              };
            };
          };
        };
      };

      boot.initrd = {
        systemd = {
          enable = true;
          services = {
            rollback = {
              description = "Rollback filesystem to a pristine state on boot";
              wantedBy = [
                "zfs.target"
                "initrd.target"
              ];
              after = [
                "zfs-import-${cfg.poolName}.service"
              ];
              before = [
                "sysroot.mount"
              ];
              path = [
                pkgs.zfs
              ];
              unitConfig.DefaultDependencies = "no";
              serviceConfig.Type = "oneshot";
              script = ''
                zfs rollback -r ${snapshotName}
              '';
            };
          };
        };
      };
    }
  );
}
