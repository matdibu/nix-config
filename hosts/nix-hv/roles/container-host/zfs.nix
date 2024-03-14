{
  disko.devices = {
    zpool = {
      "tank" = {
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
