{ config, lib, pkgs, ... }: {
  # Use latest+hardened+zfs kernel
  boot.kernelPackages = lib.mkForce (
    with builtins;
    with lib; let
      latestZfsKernel = config.boot.zfs.package.latestCompatibleLinuxPackages.kernel.version;
      hardenedPackages = filterAttrs (name: packages: hasSuffix "_hardened" name && (tryEval packages).success) pkgs.linuxKernel.packages;
      compatiblePackages = filter (packages: compareVersions packages.kernel.version latestZfsKernel <= 0) (attrValues hardenedPackages);
      orderedCompatiblePackages = sort (x: y: compareVersions x.kernel.version y.kernel.version > 0) compatiblePackages;
    in
    head orderedCompatiblePackages
  );
}