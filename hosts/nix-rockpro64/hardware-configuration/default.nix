{inputs, ...}: let
  hw-modules = inputs.nixos-hardware.nixosModules;
in {
  imports = [
    hw-modules."pine64-rockpro64"
    ./disks
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  hardware.enableAllFirmware = true;

  hardware.fancontrol.enable = false;

  nixpkgs.hostPlatform = "aarch64-linux";
}
