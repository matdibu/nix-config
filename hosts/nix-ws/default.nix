{...}: {
  imports = [
    ./hardware-configuration
    ./networking.nix
  ];

  virtualisation.podman.enable = true;

  system.stateVersion = "24.05";
}
