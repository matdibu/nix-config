{ inputs, pkgs, ... }:
let
  device = "/dev/disk/by-id/usb-Samsung_Flash_Drive_FIT_0342121020007839-0:0";
in
{
  imports = [
    inputs.self.nixosModules.profiles-server
    ./hardware.nix
    ./klipper
  ];

  modules = {
    impermanence = {
      enable = true;
      type = "zfs-tmpfs";
      inherit device;
    };
    smartd.enable = false;
  };

  environment.systemPackages = [ pkgs.raspberrypi-eeprom ];

  system.stateVersion = "24.11";
}
