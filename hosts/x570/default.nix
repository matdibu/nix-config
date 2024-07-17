{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.profiles-hm-gui
    ./hardware
    ./roles/nas
    ./roles/hypervisor.nix
    ./containers
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  specialisation = {
    "vfio".configuration = {
      imports = [ ./vfio.nix ];
    };
  };

  system.stateVersion = "24.05";
}
