{ inputs, pkgs, ... }: {
  imports = (with inputs.nixos-hardware.nixosModules; [
    common-pc
    common-pc-ssd
  ])
  ++ (with inputs.self.nixosModules; [
    profiles-intel-gpu
    profiles-intel-ucode
  ])
  ++ [
    ./disk.nix
    ./networking.nix
  ];

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

  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };
}