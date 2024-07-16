{
  flake.nixosModules = {
    profiles-better-defaults = ./better-defaults.nix;
    profiles-hm-cli = ./hm-cli.nix;
    profiles-hm-gui = ./hm-gui.nix;
    profiles-installer = ./installer.nix;
    profiles-qemu-guest = ./qemu-guest.nix;
    profiles-server = ./server.nix;
    profiles-server-minimal-hardened = ./server-minimal-hardened.nix;
  };
}
