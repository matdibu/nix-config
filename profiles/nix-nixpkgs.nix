{inputs, ...}: {
  pkgs,
  lib,
  config,
  ...
}: {
  nix = {
    package = pkgs.nixUnstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    channel.enable = false;
    nixPath = lib.singleton config.nix.settings.nix-path;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "cgroups"
        "auto-allocate-uids"
        "repl-flake"
      ];
      nix-path = "nixpkgs=flake:nixpkgs";
      use-cgroups = true;
      auto-allocate-uids = true;
      builders-use-substitutes = true;
      warn-dirty = false;
      trusted-users = [
        "@wheel"
      ];
      allowed-users = lib.mapAttrsToList (_: u: u.name) (lib.filterAttrs (_: user: user.isNormalUser) config.users.users);
      http-connections = 0;
      max-substitution-jobs = 128;
      substituters = [
        "https://nix-community.cachix.org"
        "https://mateidibu.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "mateidibu.cachix.org-1:9YiZ97RR2tUHvt79sMP0oXhP+nA3OYanCs5A2/bnmAA="
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
