{
  disko.devices = {
    zpool = {
      "nixos" = {
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
        postCreateHook = "zfs snapshot ephemeral/root@blank";
        datasets = {
          "ephemeral/root" = {
            type = "zfs_fs";
            mountpoint = "/";
          };
          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          "local/persist" = {
            type = "zfs_fs";
            mountpoint = "/mnt/persist";
          };
          "safe/persist" = {
            type = "zfs_fs";
            mountpoint = "/mnt/safe";
          };
        };
      };
    };
  };
}
