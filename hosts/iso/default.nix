{
  modulesPath,
  lib,
  pkgs,
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

  environment.systemPackages = with pkgs; [
    dmidecode
    efibootmgr
    i2c-tools
    nvme-cli
  ];

  system.stateVersion = "24.05";
}
