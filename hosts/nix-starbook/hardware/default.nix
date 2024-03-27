{ inputs, ... }: {
  imports = (with inputs.nixos-hardware.nixosModules; [
    common-pc
    common-pc-ssd
  ])
  ++ (with inputs.self.nixosModules; [
    profiles-zfs
    profiles-intel-gpu
    profiles-intel-ucode
  ])
  ++ [
    ./impermanence.nix
    ./networking.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.kernelModules = [ "nvme" ];

  hardware.enableAllFirmware = true;

  impermanence.device = "/dev/disk/by-id/";
}
