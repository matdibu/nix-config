{ config, ... }: {
  disko.devices = {
    zpool = {
      "${config.impermanence.poolName}" = {
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
