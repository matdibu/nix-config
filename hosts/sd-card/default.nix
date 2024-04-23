{ modulesPath, lib, ... }:
{
  imports = [ "${modulesPath}/installer/sd-card/sd-image-aarch64-installer.nix" ];

  services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";

  system.stateVersion = "24.05";
}
