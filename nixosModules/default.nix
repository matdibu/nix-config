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
    ./nfs.nix
    ./oci-containers.nix
    ./openssh.nix
    ./remove-docs.nix
    ./samba.nix
    ./security.nix
    ./smartd.nix
    ./user-mateidibu.nix
    ./zfs.nix
  ];
}
