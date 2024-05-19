{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-pro-ws-x570-ace
    ./disk-rootfs.nix
    ./disk-nas.nix
    ./networking.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware.rasdaemon.enable = true;
}
