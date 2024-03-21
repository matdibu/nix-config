{inputs, ...}: {
  flake.nixosModules = {
    profiles-audio = ./audio.nix;
    profiles-common = import ./common {inherit inputs;};
    profiles-nvidia = ./nvidia.nix;
    profiles-opengl = ./opengl.nix;
    profiles-qemu-guest = ./qemu-guest.nix;
    profiles-zfs = ./zfs.nix;
  };
}
