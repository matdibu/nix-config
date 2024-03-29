{
  flake.nixosModules = {
    profiles-common = ./common;
    profiles-qemu-guest = ./qemu-guest.nix;
    profiles-server-minimal-hardened = ./server-minimal-hardened.nix;
  };
}
