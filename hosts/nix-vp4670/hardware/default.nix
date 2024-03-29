{ inputs, ... }: {
  imports =
    (with inputs.nixos-hardware.nixosModules; [ common-pc common-pc-ssd ])
    ++ [ ./impermanence.nix ./networking.nix ];

  modules = {
    zfs.enable = true;
    gpu-intel.enable = true;
    impermanence = {
      enable = true;
      device = "/dev/disk/by-id/nvme-WDS200T1X0E-00AFY0_21469J442501";
    };
  };

  hardware.cpu.intel.updateMicrocode = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.kernelModules = [ "sdhci_pci" "nvme" ];

  hardware.enableAllFirmware = true;
}
