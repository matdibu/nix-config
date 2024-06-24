{ modulesPath, ... }:
{
  imports = [
    ./hardware.nix
    "${modulesPath}/image/repart.nix"
  ];

  modules = {
    impermanence = {
      enable = true;
      type = "btrfs";
      device = "/dev/disk/by-id/usb-Samsung_Flash_Drive_FIT_0342121020007839-0:0";
    };
  };

  system.stateVersion = "24.11";
}
