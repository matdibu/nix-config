{
  flake.nixosModules = {
    profiles-better-defaults = ./better-defaults.nix;
    profiles-cli = ./cli.nix;
    profiles-gui = ./gui.nix;
    profiles-installer = ./installer.nix;
    profiles-qemu-guest = ./qemu-guest.nix;
    profiles-server-minimal-hardened = ./server-minimal-hardened.nix;
  };
}
