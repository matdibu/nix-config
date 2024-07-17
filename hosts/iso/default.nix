{
  inputs,
  modulesPath,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    inputs.self.nixosModules.profiles-installer
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ./offlineTarget.nix
  ];

  isoImage = {
    makeBiosBootable = false;
    makeEfiBootable = true;
    makeUsbBootable = lib.mkForce false;
    compressImage = false;
    squashfsCompression = null;
  };

  boot.loader = {
    systemd-boot.enable = true;
    grub.enable = false;
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      dmidecode
      efibootmgr
      i2c-tools
      nvme-cli
      ;
  };

  system.stateVersion = "24.11";
}
