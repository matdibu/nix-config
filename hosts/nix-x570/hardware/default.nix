{ inputs, ... }: {
  imports = (with inputs.nixos-hardware.nixosModules; [
    common-pc
    common-pc-ssd
    common-cpu-amd-pstate
  ]) ++ [ ./impermanence.nix ./networking.nix ./nas.nix ];

  modules = {
    zfs.enable = true;
    gpu-nvidia.enable = true;
    impermanence = {
      enable = true;
      device =
        "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNF0M943331J";
    };
  };

  hardware.cpu.amd.updateMicrocode = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.kernelModules = [
    "nvme"
    # Chip `AMD Family 17h thermal sensors' (confidence: 9)
    "k10temp"
    # ISA bus, address 0x290
    # Chip `Nuvoton NCT6798D Super IO Sensors' (confidence: 9)
    "nct6775"
    # Bus `SMBus PIIX4 adapter port 1 at 0b20'
    # Busdriver `i2c_piix4', I2C address 0x4f
    # Chip `Dallas Semiconductor DS75' (confidence: 3)
    # "lm75"
  ];
}
