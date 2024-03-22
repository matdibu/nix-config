{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [ pkgs.microcodeIntel ];

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
  };
}
