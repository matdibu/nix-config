{inputs, modulesPath, ...}: {
  imports =
    [
  "${modulesPath}/profiles/qemu-guest.nix"
      ./disks
    ]
    ++ (with inputs.self.nixosModules; [
      profiles-nvidia
    ]);

  services.qemuGuest.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableAllFirmware = true;

  nixpkgs.hostPlatform = "x86_64-linux";
}
