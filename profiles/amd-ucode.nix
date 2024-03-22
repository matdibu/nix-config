{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [ pkgs.microcodeAmd ];

  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
  };
}
