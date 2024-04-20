{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.disko.nixosModules.default
    ./better-defaults.nix
    ./better-nix.nix
    ./docs.nix
    ./graphics
    ./impermanence.nix
    ./impermanence-btrfs.nix
    ./networking.nix
    ./openssh.nix
    ./security.nix
    ./smartd.nix
    ./users.nix
    ./zfs.nix
  ];
}
