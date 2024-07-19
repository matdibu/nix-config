{ modulesPath, ... }:
{
  imports = [ "${modulesPath}/profiles/qemu-guest.nix" ];

  boot.kernelParams = [
    "console=hvc0"
    "console=ttyS0,115200n8"
  ];

  services.qemuGuest.enable = true;
}
