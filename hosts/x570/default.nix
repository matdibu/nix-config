{ inputs, ... }:
{
  imports = [
    ./hardware
    ./overlays
    ./roles/nas
    ./containers
  ];

  specialisation = {
    "vfio".configuration = {
      imports = [ ./roles/hypervisor ];
    };
    "steam".configuration = {
      imports = [
        inputs.self.nixosModules.profiles-gui
        ./openmw.nix
      ];
      modules = {
        gpu-nvidia.enable = true;
        steam.enable = true;
      };
      # environment.systemPackages = [ pkgs.openmw ];
    };
  };

  system.stateVersion = "24.05";
}
