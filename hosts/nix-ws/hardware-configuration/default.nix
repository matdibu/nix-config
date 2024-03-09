{inputs, ...}: {
  imports =
    [
      ./disks
    ]
    ++ (with inputs.self.nixosModules; [
      profiles-nvidia
      profiles-qemu-guest
    ]);

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableAllFirmware = true;

  nixpkgs.hostPlatform = "x86_64-linux";
}
