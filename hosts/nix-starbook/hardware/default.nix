{ inputs, pkgs, ... }: {
  imports =
    (with inputs.nixos-hardware.nixosModules; [ common-pc common-pc-ssd ])
    ++ [ ./disk.nix ./networking.nix ];

  modules = {
    gpu-intel.enable = true;
    ucode-intel.enable = true;
  };

  boot = {
    initrd.systemd.enable = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Don't allow mutation of users outside of the config.
  users.mutableUsers = false;

  hardware.enableAllFirmware = true;

  hardware.mcelog.enable = true;
}
