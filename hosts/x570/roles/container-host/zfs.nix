{ config, ... }:
{
  disko.devices = {
    zpool = {
      ${config.modules.impermanence.poolName} = {
        datasets = {
          "system/containers" = {
            type = "zfs_fs";
            mountpoint = "/mnt/containers";
          };
        };
      };
    };
  };
}
