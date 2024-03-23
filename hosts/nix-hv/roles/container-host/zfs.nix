{ config, ... }: {
  disko.devices = {
    zpool = {
      "${config.impermanence.poolName}" = {
        datasets = {
          "system/container-storage" = {
            type = "zfs_fs";
            mountpoint = "/container-storage";
          };
        };
      };
    };
  };
}
