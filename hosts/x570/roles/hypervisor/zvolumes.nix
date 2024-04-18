{ config, ... }:
{
  disko.devices = {
    zpool = {
      "${config.impermanence.poolName}" = {
        datasets = {
          "system/vm-storage" = {
            type = "zfs_fs";
            mountpoint = "/vm-storage";
          };
        };
      };
    };
  };
}
