{ inputs, modulesPath, ... }:
{
  imports = [
    inputs.self.nixosModules.profiles-installer
    "${modulesPath}/installer/sd-card/sd-image.nix"
  ];

  boot.loader.generic-extlinux-compatible.enable = true;

  system.stateVersion = "24.11";
}
