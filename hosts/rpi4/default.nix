{ pkgs, lib, ... }:
{
  imports = [
    ./hardware.nix
    ./klipper
  ];

  modules = {
    smartd.enable = false;
    system-type.stype = "server";
  };

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_rpi4;

  environment.systemPackages = [ pkgs.raspberrypi-eeprom ];

  system.stateVersion = "24.11";
}
