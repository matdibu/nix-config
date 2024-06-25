{ modulesPath, pkgs, ... }:
{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

  isoImage = {
    # makeBiosBootable = true;
    makeEfiBootable = true;
    makeUsbBootable = true;
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
