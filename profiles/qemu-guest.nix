{modulesPath, ...}: {
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  # enable serial console
  boot.kernelParams = ["console=ttyS0,115200n8"];

  services.qemuGuest.enable = true;
}
