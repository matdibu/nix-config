{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.protectli-vp4670
    ./disk.nix
    ./networking.nix
  ];

  modules = {
    gpu-intel.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  powerManagement.cpuFreqGovernor = "performance";
}
