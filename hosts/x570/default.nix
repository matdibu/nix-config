{ inputs, ... }:
{
  imports = [
    ./hardware.nix
    ./services/hypervisor.nix
    inputs.self.nixosModules.profiles-lan-filesharing
  ];

  modules.system-type.stype = "graphical-desktop";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  specialisation = {
    "vfio".configuration = {
      imports = [ ./specialisations/vfio.nix ];
    };
  };

  system.stateVersion = "24.11";
}
