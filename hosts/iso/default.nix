{
  modulesPath,
  lib,
  config,
  ...
}:
{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

  isoImage = {
    # makeBiosBootable = true;
    makeEfiBootable = true;
    makeUsbBootable = true;
  };

  services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  # use DHCP on all interfaces
  networking.useDHCP = lib.mkForce true;
  systemd.network.enable = lib.mkForce false;
  boot.initrd.systemd.enable = lib.mkForce false;

  system.stateVersion = "24.05";
}
