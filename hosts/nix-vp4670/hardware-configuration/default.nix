{inputs, ...}: let
  hw-modules = inputs.nixos-hardware.nixosModules;
in {
  imports = [
    hw-modules.common-pc
    hw-modules.common-pc-ssd
    hw-modules.common-cpu-intel
    ./intel-ucode.nix
    ./smartd.nix
    ./disks
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.kernelModules = ["sdhci_pci" "i915"];
  boot.kernelParams = [
    "i915.enable_guc=3"
    "i915.modeset=1"
  ];

  hardware.enableAllFirmware = true;

  nixpkgs.hostPlatform = "x86_64-linux";
}
