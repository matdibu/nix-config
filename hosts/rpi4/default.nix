let
  device = "/dev/disk/by-id/usb-Samsung_Flash_Drive_FIT_0341021050006031-0:0";
in
{
  imports = [
    ./hardware.nix
  ];

  modules = {
    impermanence = {
        enable = true;
        type = "zfs-tmpfs";
        inherit device;
    };
  };

  system.stateVersion = "24.11";
}
