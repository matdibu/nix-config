{
  imports = [
    ./hardware.nix
    ./services/containers
    ./services/nas.nix
  ];

  modules.system-type.stype = "graphical-desktop";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  system.stateVersion = "24.11";
}
