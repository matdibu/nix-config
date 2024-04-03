{ inputs, pkgs, ... }:
{
  imports =
    (with inputs.nixos-hardware.nixosModules; [
      common-pc
      common-pc-ssd
    ])
    ++ [
      ./disk.nix
      ./networking.nix
      # ./fwupd.nix # disabled because it affects security
    ];

  modules = {
    gpu-intel.enable = true;
  };

  boot = {
    initrd.systemd.enable = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware.cpu.intel.updateMicrocode = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Don't allow mutation of users outside of the config.
  users.mutableUsers = false;

  hardware.enableAllFirmware = true;

  hardware.rasdaemon.enable = true;
}
