_:
let
  device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNX0NA05054K";
  diskName = "nas";
  poolName = "nas";
in
{
  disko.devices = {
    disk = {
      ${diskName} = {
        inherit device;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = poolName;
              };
            };
          };
        };
      };
    };
    zpool = {
      ${poolName} = {
        type = "zpool";
        options = {
          ashift = "12";
          autotrim = "on";
        };
        mountpoint = "/mnt";
        rootFsOptions = {
          compression = "lz4";
          "com.sun:auto-snapshot" = "false";
          atime = "off";
          xattr = "sa";
          acltype = "posixacl";
        };
        datasets = {
          "torrents" = {
            type = "zfs_fs";
            mountpoint = "/torrents";
          };
        };
      };
    };
  };
}
