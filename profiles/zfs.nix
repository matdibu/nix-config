{config, ...}: {
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
}
