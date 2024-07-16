{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    filterAttrs
    mkEnableOption
    mkIf
    hasSuffix
    tryEval
    filter
    attrValues
    sort
    compareVersions
    head
    ;
  cfg = config.modules.zfs;
in
{
  options = {
    modules.zfs = {
      enable = mkEnableOption "ZFS support";
      hardened = mkEnableOption "latest compatible hardened kernel";
    };
  };

  config = mkIf cfg.enable (
    let
      kernelLatestZfs = config.boot.zfs.package.latestCompatibleLinuxPackages;
      kernelLatestZfsHardened =
        let
          hardenedPackages = filterAttrs (
            name: packages: hasSuffix "_hardened" name && (tryEval packages).success
          ) pkgs.linuxKernel.packages;

          compatiblePackages = filter (
            packages: compareVersions packages.kernel.version kernelLatestZfs.kernel.version <= 0
          ) (attrValues hardenedPackages);

          orderedCompatiblePackages = sort (
            x: y: compareVersions x.kernel.version y.kernel.version > 0
          ) compatiblePackages;
        in
        head orderedCompatiblePackages;
    in
    {
      boot = {
        kernelPackages = if cfg.hardened then kernelLatestZfsHardened else kernelLatestZfs;
        initrd.supportedFilesystems = [ "zfs" ];
        # fix for VM's, where devices might not have serial numbers
        # zfs.devNodes = "/dev/disk/by-partuuid";
      };
      systemd.services.zfs-mount.enable = false;
    }
  );
}
