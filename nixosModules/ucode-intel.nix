{ pkgs, lib, config, ... }: {
  options = {
    modules.ucode-intel.enable = lib.mkEnableOption "ucode for Intel cpus";
  };
  config = lib.mkIf config.modules.ucode-intel.enable {
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = [ pkgs.microcodeIntel ];

    hardware = {
      enableAllFirmware = true;
      cpu.intel.updateMicrocode = true;
    };
  };
}
