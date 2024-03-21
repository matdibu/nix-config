{inputs, ...}: {
  imports = [
    ./docs.nix
    ./misc.nix
    ./networking.nix
    (import
      ./nix-nixpkgs.nix
      {inherit inputs;})
    ./openssh.nix
    ./security.nix
    ./users.nix
  ];
}
