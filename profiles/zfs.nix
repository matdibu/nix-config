{ config, lib, ... }: {
  boot = {
    kernelPackages = lib.mkDefault config.boot.zfs.package.latestCompatibleLinuxPackages;
    initrd.supportedFilesystems = [ "zfs" ];
    zfs.devNodes = "/dev/disk/by-partuuid";
  };
  systemd.services.zfs-mount.enable = false;
}
