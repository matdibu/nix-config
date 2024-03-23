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

  boot.initrd.kernelModules = [ "sdhci_pci" "nvme" ];

  hardware.enableAllFirmware = true;

  impermanence.device = "/dev/disk/by-id/nvme-WDS200T1X0E-00AFY0_21469J442501";
}
