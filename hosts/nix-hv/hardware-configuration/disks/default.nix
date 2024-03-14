{inputs, ...}: {
  imports = [
    inputs.self.nixosModules.profiles-impermanence
    ./impermanence.nix
  ];

  disko.devices.disk."root".device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNF0M943331J";
}
