{ inputs, ... }:
{
  imports =
    (with inputs.nixos-hardware.nixosModules; [
      common-pc
      common-pc-ssd
      common-cpu-amd-pstate
    ])
    ++ [
      ./disk.nix
      ./networking.nix
      ./nas.nix
    ];

  modules = {
    gpu-nvidia.enable = true;
  };

  hardware.cpu.amd.updateMicrocode = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  powerManagement.cpuFreqGovernor = "performance";

  boot.kernelModules = [
    # Chip `AMD Family 17h thermal sensors'
    "k10temp"

    # ISA bus, address 0x290
    # Chip `Nuvoton NCT6798D Super IO Sensors'
    "nct6775"

    # dependencies for i2c communication
    "i2c-dev"
    "i2c-piix4"

    # Bus `SMBus PIIX4 adapter port 1 at 0b20'
    # Busdriver `i2c_piix4', I2C address 0x4f
    # Chip `lm75'
    "lm75"

    # Bus `SMBus PIIX4 adapter port 0 at 0b00'
    # Busdriver `i2c_piix4', I2C address 0x18/0x19/0x1a/0x1b
    # Chip `jc42'
    "jc42"

    # ram SPD EEPROM, for 'decode-dimms'
    "ee1004"
  ];
}
