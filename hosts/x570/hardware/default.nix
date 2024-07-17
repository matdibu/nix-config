{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-pro-ws-x570-ace
    ./disk.nix
    ./networking.nix
  ];

  modules = {
    gpu-nvidia.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware.rasdaemon.enable = true;
}
