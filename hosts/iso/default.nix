{
  modulesPath,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ./offlineInstallers.nix
  ];

  modules.system-type = "installer";

  isoImage = {
    makeBiosBootable = false;
    makeEfiBootable = true;
    makeUsbBootable = lib.mkForce false;
    squashfsCompression = "zstd";
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
