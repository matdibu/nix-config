{ lib, config, ... }:
let
  cfg = config.modules.impermanence;
in
{
  config = lib.mkIf (cfg.enable && (cfg.type == "zfs-tmpfs")) {
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
          datasets =
            {
              "system" = {
                type = "zfs_fs";
              };
              "system/nix" = {
                type = "zfs_fs";
                mountpoint = "/nix";
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
  };
}
