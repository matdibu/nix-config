{inputs, ...}: {
  imports = [
    inputs.self.nixosModules.profiles-impermanence
    ./impermanence.nix
  ];
}
