{inputs, ...}: {
  flake.nixosModules = {
    profiles-audio = ./audio.nix;
    profiles-docs = ./docs.nix;
    # profiles-impermanence = import ./impermanence.nix {inherit inputs;};
    profiles-impermanence-root = import ./impermanence-root.nix {inherit inputs;};
    profiles-misc = ./misc.nix;
    profiles-networking = ./networking.nix;
    profiles-nix-nixpkgs = import ./nix-nixpkgs.nix {inherit inputs;};
    profiles-nvidia = ./nvidia.nix;
    profiles-opengl = ./opengl.nix;
    profiles-openssh = ./openssh.nix;
    profiles-qemu-guest = ./qemu-guest.nix;
    profiles-security = ./security.nix;
    profiles-users = ./users.nix;
    profiles-wayland = ./wayland.nix;
    profiles-zfs = ./zfs.nix;
    # profiles-zfs-volumes = ./zfs-volumes.nix;
  };
}
