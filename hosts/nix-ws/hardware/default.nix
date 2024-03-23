{ inputs, ... }: {
  imports =
    (with inputs.self.nixosModules; [
      profiles-nvidia
      profiles-qemu-guest
    ]) ++
    [
      ./networking.nix
      ./impermanence.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  impermanence.device = "/dev/disk/by-path/virtio-pci-0000:00:07.0";

  hardware.enableAllFirmware = true;
}
