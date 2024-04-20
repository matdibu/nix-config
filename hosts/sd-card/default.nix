{
  modulesPath,
  lib,
  config,
  ...
}:
{
  imports = [ "${modulesPath}/installer/sd-card/sd-image-aarch64-installer.nix" ];

  services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  # use DHCP on all interfaces
  networking.useDHCP = lib.mkForce true;
  systemd.network.enable = lib.mkForce false;

  system.stateVersion = "24.05";
}