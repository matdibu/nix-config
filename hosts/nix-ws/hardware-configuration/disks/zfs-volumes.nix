{lib, ...}: let
  root_snapshot_name = "nixos/tmp@blank";
  persist_path = "/mnt/persist";
in {
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r ${root_snapshot_name}
  '';

  disko.devices = {
    zpool = {
      "tank" = {
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
        postCreateHook = "zfs snapshot ${root_snapshot_name}";
        datasets = {
          "tmp" = {
            type = "zfs_fs";
            mountpoint = "/tmp";
          };
          "nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          "persist" = {
            type = "zfs_fs";
            mountpoint = "${persist_path}";
          };
        };
      };
    };
  };
}
