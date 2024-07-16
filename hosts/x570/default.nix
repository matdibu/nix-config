{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.profiles-hm-gui
    ./hardware
    ./roles/nas
    ./containers
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  specialisation = {
    "vfio".configuration = {
      imports = [ ./roles/hypervisor ];
    };
  };

  system.stateVersion = "24.05";
}
