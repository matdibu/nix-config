{inputs, ...}: {
  imports =
    [
      ./networking.nix
      ./impermanence.nix
    ]
    ++ (with inputs.self.nixosModules; [
      profiles-nvidia
      profiles-qemu-guest
    ]);

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  impermanence.device = "/dev/disk/by-path/virtio-pci-0000:00:07.0";

  hardware.enableAllFirmware = true;
}
