{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.profiles-hm-gui
    ./hardware
    # ./containers
    # ./nas
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  system.stateVersion = "24.05";
}
