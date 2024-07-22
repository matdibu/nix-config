{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./klipper
  ];

  modules = {
    smartd.enable = false;
    system-type.stype = "server";
  };

  environment.systemPackages = [ pkgs.raspberrypi-eeprom ];

  system.stateVersion = "24.11";
}
