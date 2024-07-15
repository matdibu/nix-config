{
  imports = [
    ./hardware
    # ./containers
    # ./nas
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  system.stateVersion = "24.05";
}
