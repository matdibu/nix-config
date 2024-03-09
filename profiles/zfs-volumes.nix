{lib, ...}:
let
  pool_name = "tank";
  root_snapshot_name = "${pool_name}/system/tmp@blank";
  persist_path = "/mnt/persist";
in
{
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r ${root_snapshot_name}
  '';

  disko.devices = {
    zpool = {
      "${pool_name}" = {
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
          "system" = {
            type = "zfs_fs";
          };
          "system/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          "system/tmp" = {
            type = "zfs_fs";
            mountpoint = "/tmp";
          };
          "system/persist" = {
            type = "zfs_fs";
            mountpoint = "${persist_path}";
          };
        };
      };
    };
  };
}
