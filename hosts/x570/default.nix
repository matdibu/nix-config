# { inputs, ... }:
{
  imports = [
    # inputs.self.nixosModules.profiles-hm-gui
    ./hardware
    ./services/hypervisor.nix
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
