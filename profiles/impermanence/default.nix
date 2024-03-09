{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ../zfs.nix
    ./disk.nix
    ./volumes.nix
    ./config.nix
  ];
}
