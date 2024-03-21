{
  # disko.devices.disk."root".device = "/dev/disk/by-path/pci-0000:08:00.0-nvme-1";

  imports = [
    # inputs.self.nixosModules.s-impermanence
    ./impermanence.nix
  ];
}
