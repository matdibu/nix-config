{inputs, ...}: {
  imports = with inputs.nixos-hardware.nixosModules;
    [
      common-pc
      common-pc-ssd
      common-cpu-intel
    ]
    ++ (with inputs.self.nixosModules; [
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

  boot.initrd.kernelModules = ["sdhci_pci" "i915"];
  boot.kernelParams = [
    "i915.enable_guc=3"
    "i915.modeset=1"
  ];

  hardware.enableAllFirmware = true;

  impermanence.device = "/dev/disk/by-path/pci-0000:08:00.0-nvme-1";
}
