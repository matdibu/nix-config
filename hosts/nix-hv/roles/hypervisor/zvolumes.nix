{
  disko.devices = {
    zpool = {
      "tank" = {
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
