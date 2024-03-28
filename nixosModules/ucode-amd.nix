{ pkgs, lib, config, ... }: {
  options = {
    modules.ucode-amd.enable = lib.mkEnableOption "ucode for AMD cpus";
  };
  config = lib.mkIf config.modules.ucode-amd.enable {
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = [ pkgs.microcodeAmd ];

    hardware = {
      enableAllFirmware = true;
      cpu.amd.updateMicrocode = true;
    };
  };
}
