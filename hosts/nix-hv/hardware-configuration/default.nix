{inputs, ...}: let
  hw-modules = inputs.nixos-hardware.nixosModules;
in {
  imports = [
    hw-modules.common-pc
    hw-modules.common-pc-ssd
    hw-modules.common-cpu-amd-pstate
    ./amd-ucode.nix
    ./smartd.nix
    ./disks
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware.enableAllFirmware = true;

  nixpkgs.hostPlatform = "x86_64-linux";
}
