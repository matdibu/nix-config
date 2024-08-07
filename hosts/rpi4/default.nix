{ inputs, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./klipper
    inputs.self.nixosModules.profiles-lan-filesharing
  ];

  modules = {
    smartd.enable = false;
    system-type = "server";
  };

  environment.systemPackages = [
    pkgs.raspberrypi-eeprom
    pkgs.libraspberrypi
  ];

  system.stateVersion = "24.11";
}
