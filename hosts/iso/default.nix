{ modulesPath, lib, ... }:
{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

  isoImage = {
    # makeBiosBootable = true;
    makeEfiBootable = true;
    makeUsbBootable = true;
  };

  services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";

  system.stateVersion = "24.05";
}
