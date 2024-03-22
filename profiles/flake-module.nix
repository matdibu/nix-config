{
  flake.nixosModules = {
    profiles-audio = ./audio.nix;
    profiles-amd-ucode = ./amd-ucode.nix;
    profiles-common = ./common;
    profiles-intel-ucode = ./intel-ucode.nix;
    profiles-nvidia = ./nvidia.nix;
    profiles-qemu-guest = ./qemu-guest.nix;
    profiles-zfs = ./zfs.nix;
  };
}
