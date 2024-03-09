# SPDX-FileCopyrightText: 2024 Matei Dibu <matei@mateidibu.dev>
#
# SPDX-License-Identifier: MIT
{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./zfs-tank.nix
  ];

  boot = {
    kernelPackages = lib.mkDefault config.boot.zfs.package.latestCompatibleLinuxPackages;
    initrd.supportedFilesystems = ["zfs"];
    supportedFilesystems = ["zfs"];
    zfs.devNodes = "/dev/disk/by-partuuid";
  };
  systemd.services.zfs-mount.enable = false;

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
        type = "disk";
        device = "/dev/disk/by-path/virtio-pci-0000:00:07.0";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
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
  };
}
