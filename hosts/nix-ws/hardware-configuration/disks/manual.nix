{lib, inputs, config, ...}: 
let
  pool_name = "tank";
  root_snapshot_name = "${pool_name}/system/tmp@blank";
  persist_path = "/mnt/persist";
in


{
  imports = [
    inputs.disko.nixosModules.disko
  ];
  boot = {
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    initrd.supportedFilesystems = ["zfs"];
    supportedFilesystems = ["zfs"];
    zfs = {
devNodes = "/dev/disk/by-partuuid";
    forceImportRoot = true;
    forceImportAll = true;
extraPools = [ "tank" ];
};
  };
  systemd.services.zfs-mount.enable = false;

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r ${root_snapshot_name}
  '';

  disko.devices = {
    nodev."/" = {
fsType = "tmpfs";
          mountOptions = [
            "mode=755"
             "noatime"
          ];
};
    disk = {
      "root" = {
        # inherit device;
        device = "/dev/disk/by-path/pci-0000:00:07.0";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0137"
                  "dmask=0027"
                  "noatime"
                ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "tank";
              };
            };
          };
        };
      };
    };
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




