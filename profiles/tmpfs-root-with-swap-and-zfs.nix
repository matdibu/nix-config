{
  modules = {
    simple-impermanence.enable = true;
    zfs.enable = true;
  };

  boot.zfs.extraPools = [ "tank" ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "mode=755" ];
  };

  disko.devices = {
    disk = {
      "root-disk" = {
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                extraArgs = [ "-F32" ];
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0137"
                  "dmask=0027"
                  "noatime"
                ];
              };
            };

            swap = {
              size = "8G";
              content = {
                type = "swap";
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
        datasets = {
          "system" = {
            type = "zfs_fs";
          };
          "system/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          "system/persist" = {
            type = "zfs_fs";
            mountpoint = "/mnt/persist";
          };
        };
      };
    };
  };
}
