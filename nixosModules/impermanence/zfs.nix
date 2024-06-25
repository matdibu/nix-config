{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.impermanence;
in
{
  config = lib.mkIf (cfg.enable && (cfg.type == "zfs")) (
    let
      snapshotName = "${cfg.poolName}/system/root@blank";
    in
    {
      modules.zfs.enable = true;
      boot.zfs.extraPools = [ "${cfg.poolName}" ];

      modules.impermanence.disko-devices = {
        disk = {
          "root-impermanence" = {
            content = {
              partitions = {
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
            datasets =
              {
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
                  mountpoint = "/mnt/persist";
                };
              }
              // lib.mergeAttrsList (
                builtins.map (volume: {
                  "system/${volume}" = {
                    type = "zfs_fs";
                    mountpoint = "/mnt/${volume}";
                  };
                }) cfg.extraVolumes
              );
          };
        };
      };

      boot.initrd.systemd.services."rollback-zfs-rootfs" = {
        description = "Rollback ZFS rootfs to a pristine state";
        wantedBy = [
          "zfs.target"
          "initrd.target"
        ];
        after = [ "zfs-import-${cfg.poolName}.service" ];
        before = [ "sysroot.mount" ];
        path = [ pkgs.zfs ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          zfs rollback -r ${snapshotName}
        '';
      };
    }
  );
}
