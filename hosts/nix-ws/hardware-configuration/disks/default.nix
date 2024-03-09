{inputs, ...}: {
  # disko.devices.disk."root".device = device;

  imports = with inputs.self.nixosModules; [
    profiles-impermanence-root
    # ./OLD.nix
  ];
}
