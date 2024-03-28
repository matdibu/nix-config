{ config, lib, pkgs, ... }: {
  options = {
    modules.zfs = {
      enable = lib.mkEnableOption "ZFS support";
      hardened = lib.mkEnableOption "latest compatible hardened kernel";
    };
  };
  config = lib.mkIf config.modules.zfs.enable
    (
      let
        kernelLatestZfs = config.boot.zfs.package.latestCompatibleLinuxPackages;
        kernelLatestZfsHardened =
          let
            hardenedPackages = lib.filterAttrs (name: packages: lib.hasSuffix "_hardened" name && (lib.tryEval packages).success) pkgs.linuxKernel.packages;
            compatiblePackages = lib.filter (packages: lib.compareVersions packages.kernel.version kernelLatestZfs.kernel.version <= 0) (lib.attrValues hardenedPackages);
            orderedCompatiblePackages = lib.sort (x: y: lib.compareVersions x.kernel.version y.kernel.version > 0) compatiblePackages;
          in
          lib.head orderedCompatiblePackages;
      in
      {
        boot = {
          kernelPackages = lib.mkDefault (
            if config.modules.zfs.hardened then kernelLatestZfsHardened else kernelLatestZfs
          );
          initrd.supportedFilesystems = [ "zfs" ];
          # fix for VM's, where devices might not have serial numbers
          zfs.devNodes = "/dev/disk/by-partuuid";
        };
        systemd.services.zfs-mount.enable = false;
      }
    );
}
