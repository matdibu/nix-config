{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.disko.nixosModules.default
    ./audio.nix
    ./better-defaults.nix
    ./better-networking.nix
    ./better-nix.nix
    ./gpu-intel.nix
    ./gpu-nvidia.nix
    ./impermanence.nix
    ./nfs.nix
    ./oci-containers.nix
    ./openssh.nix
    ./remove-docs.nix
    ./samba.nix
    ./security.nix
    ./smartd.nix
    ./steam.nix
    ./sway.nix
    ./user-mateidibu.nix
    ./wayland.nix
    ./xdg-portal.nix
    ./zfs.nix
  ];
}
