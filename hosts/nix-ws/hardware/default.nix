{ inputs, ... }: {
  imports =
    (with inputs.self.nixosModules; [
      profiles-qemu-guest
    ]) ++
    [
      ./networking.nix
      ./impermanence.nix
    ];

  modules.gpu-nvidia.enable = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  modules.impermanence = {
    enable = true;
    device = "/dev/disk/by-path/virtio-pci-0000:00:07.0";
  };

  hardware.enableAllFirmware = true;
}
