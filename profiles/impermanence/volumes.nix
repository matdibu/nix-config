{
  lib,
  config,
  ...
}: let
  pool_name = "tank";
  root_snapshot_name = "${pool_name}/system/tmp@blank";
  persist_path = "/mnt/persist";
in {
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r ${root_snapshot_name}
  '';
  fileSystems.${persist_path}.neededForBoot = true;

  services.openssh = lib.mkIf config.services.openssh.enable {
    hostKeys = [
      {
        path = "${persist_path}/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "${persist_path}/ssh/ssh_host_rsa_key";
        type = "rsa";
        # bits=4096; # not impermanence-relevant
      }
    ];
  };

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
