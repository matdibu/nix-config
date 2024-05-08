{ inputs, ... }:
{
  imports = [
    ./hardware
    ./roles/nas
    ./roles/container-host
  ];

  specialisation = {
    "vfio".configuration = {
      imports = [ ./roles/hypervisor ];
    };
    "steam".configuration = {
      imports = [ inputs.self.nixosModules.profiles-gui ];
      modules = {
        gpu-nvidia.enable = true;
        steam.enable = true;
      };
    };
  };

  system.stateVersion = "24.05";
}
