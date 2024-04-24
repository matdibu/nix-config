{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-pro-ws-x570-ace
    ./disk-rootfs.nix
    ./disk-nas.nix
    ./networking.nix
  ];

  modules = {
    gpu-nvidia.enable = true;
  };

  hardware.cpu.amd.updateMicrocode = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  powerManagement.cpuFreqGovernor = "performance";
}
