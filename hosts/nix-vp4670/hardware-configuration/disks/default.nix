{inputs, ...}: {
  disko.devices.disk."root".device = "/dev/disk/by-id/mmc-AJTD4R_0x12edbef5";

  imports = [
    inputs.self.nixosModules.profiles-impermanence
    ./impermanence.nix
  ];
}
