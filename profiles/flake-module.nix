{
  flake.nixosModules = {
    profiles-lan-filesharing = ./lan-filesharing.nix;
    profiles-qemu-guest = ./qemu-guest.nix;
    profiles-server-minimal-hardened = ./server-minimal-hardened.nix;
    profiles-tmpfs-root-with-swap-and-zfs = ./tmpfs-root-with-swap-and-zfs.nix;
  };
}
