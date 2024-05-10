{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules."pine64-rockpro64"
    ./kernel.nix
    ./networking.nix
    ./disk.nix
  ];

  modules = {
    smartd.enable = false;
  };

  # using tow-boot
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };
}
