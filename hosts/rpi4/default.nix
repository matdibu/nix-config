{ pkgs, ... }:
let
  device = "/dev/disk/by-id/usb-Samsung_Flash_Drive_FIT_0342121020007839-0:0";
in
{
  imports = [
    ./hardware.nix
    ./klipper.nix
  ];

  modules = {
    impermanence = {
      enable = true;
      type = "zfs-tmpfs";
      inherit device;
    };
  };

  nixpkgs.overlays = [
    (_final: prev: {
      klipper-firmware = prev.klipper-firmware.override { gcc-arm-embedded = pkgs.gcc-arm-embedded-13; };
    })
  ];

  environment.systemPackages = [ pkgs.raspberrypi-eeprom ];

  system.stateVersion = "24.11";
}
