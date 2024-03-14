{
  disko.devices = {
    disk = {
      "nas" = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNX0NA05054K";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "nas";
              };
            };
          };
        };
      };
    };
    zpool = {
      "nas" = {
        type = "zpool";
        options = {
          ashift = "12";
          autotrim = "on";
        };
        mountpoint = null;
        rootFsOptions = {
          compression = "lz4";
          "com.sun:auto-snapshot" = "false";
          atime = "off";
          xattr = "sa";
          acltype = "posixacl";
        };
        datasets = {
          "ephemeral" = {
            type = "zfs_fs";
          };
          "ephemeral/torrents" = {
            type = "zfs_fs";
            mountpoint = "/torrents";
          };
          "archive" = {
            type = "zfs_fs";
          };
          "archive/photos" = {
            type = "zfs_fs";
            mountpoint = "/photos";
          };
        };
      };
    };
  };
}
