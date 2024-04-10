{ modulesPath, ... }:
{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    ./hardware
  ];

  system.stateVersion = "24.05";
}
