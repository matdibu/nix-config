{
  flake.nixosModules = {
    profiles-audio = ./audio.nix;
    profiles-common = ./common;
    profiles-nvidia = ./nvidia.nix;
    profiles-opengl = ./opengl.nix;
    profiles-qemu-guest = ./qemu-guest.nix;
    profiles-zfs = ./zfs.nix;
  };
}
