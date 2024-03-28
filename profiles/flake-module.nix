{
  flake.nixosModules = {
    profiles-common = ./common;
    profiles-headless = ./headless.nix;
    profiles-qemu-guest = ./qemu-guest.nix;
    profiles-server-minimal-hardened = ./server-minimal-hardened.nix;
    profiles-sway = ./sway;
  };
}
