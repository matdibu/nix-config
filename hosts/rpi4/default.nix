{ inputs, pkgs, ... }:
{
  imports = [
    inputs.self.nixosModules.profiles-better-defaults
    ./hardware.nix
    ./klipper
  ];

  modules = {
    smartd.enable = false;
  };

  environment.systemPackages = [ pkgs.raspberrypi-eeprom ];

  system.stateVersion = "24.11";
}
