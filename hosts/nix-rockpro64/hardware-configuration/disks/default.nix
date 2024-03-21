{inputs, ...}: {
  imports = [
    inputs.self.nixosModules.modules-impermanence
    ./impermanence.nix
  ];

  disko.devices.disk."root".device = "/dev/disk/by-path/platform-fe330000.mmc";
}
