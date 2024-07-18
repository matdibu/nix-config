{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.profiles-hm-gui
    ./hardware
    ./services/hypervisor.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  specialisation = {
    "vfio".configuration = {
      imports = [ ./specialisations/vfio.nix ];
    };
  };

  system.stateVersion = "24.11";
}
