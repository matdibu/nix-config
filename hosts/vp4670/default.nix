{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.profiles-hm-gui
    ./hardware
    ./services/containers
    ./services/nas.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  system.stateVersion = "24.11";
}
