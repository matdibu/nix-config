{ inputs, pkgs, ... }:
{
  imports = [
    ./hardware
    ./roles/nas
    ./roles/container-host
    ./openmw.nix
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
      environment.systemPackages = [ pkgs.openmw ];
    };
  };

  system.stateVersion = "24.05";
}
