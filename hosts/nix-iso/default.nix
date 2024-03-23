{ modulesPath
, pkgs
, lib
, config
, ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";

  environment.systemPackages = with pkgs; [
    gitMinimal
  ];

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  # use DHCP on all interfaces
  networking.useDHCP = lib.mkForce true;
  systemd.network.enable = lib.mkForce false;
}
