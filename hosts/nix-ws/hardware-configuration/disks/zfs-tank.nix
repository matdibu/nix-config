# SPDX-FileCopyrightText: 2024 Matei Dibu <matei@mateidibu.dev>
#
# SPDX-License-Identifier: MIT
_: {
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
            mountpoint = "/persist";
          };
          "system/tmp" = {
            type = "zfs_fs";
            mountpoint = "/tmp";
          };
        };
      };
    };
  };
}
