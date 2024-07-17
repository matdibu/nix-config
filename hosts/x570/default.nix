{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.profiles-hm-gui
    ./hardware
    ./services/hypervisor.nix
    ./services/nfs.nix
    ./services/samba.nix
    ./containers
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  specialisation = {
    "vfio".configuration = {
      imports = [ ./specialisations/vfio.nix ];
    };
  };

  system.stateVersion = "24.05";
}
