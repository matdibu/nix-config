{ self, pkgs, ... }:
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
      imports = [ self.nixosModules.profiles-gui ];
      programs.steam = {
        enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };
    };
  };

  system.stateVersion = "24.05";
}
