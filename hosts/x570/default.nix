{ inputs, ... }:
{
  imports = [
    ./hardware
    ./roles/nas
    ./containers
    inputs.self.nixosModules.profiles-gui
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  modules = {
    gpu-nvidia.enable = true;
  };

  specialisation = {
    "vfio".configuration = {
      imports = [ ./roles/hypervisor ];
    };
  };

  system.stateVersion = "24.05";
}
