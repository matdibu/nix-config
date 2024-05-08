{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-pro-ws-x570-ace
    ./disk-rootfs.nix
    ./disk-nas.nix
    ./networking.nix
    # ./amd_pstate.nix # didn't improve performance
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelParams = [ "amd_pstate=guided" ];

  powerManagement.cpuFreqGovernor = "performance";

  hardware.rasdaemon = {
    enable = true;
  };
}
