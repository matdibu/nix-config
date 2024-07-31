{
  imports = [
    ./hardware.nix
    ./services/containers
    ./services/nas.nix
  ];

  modules.system-type = "graphical-desktop";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  system.stateVersion = "24.11";
}
