{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.disko.nixosModules.default
    ./better-defaults.nix
    ./better-networking.nix
    ./better-nix.nix
    ./graphics
    ./impermanence
    ./openssh.nix
    ./remove-docs.nix
    ./security.nix
    ./smartd.nix
    ./user-mateidibu.nix
    ./zfs.nix
  ];
}
