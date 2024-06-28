{ lib, config, ... }:
{
  options = {
    modules.better-nix.enable = lib.mkEnableOption "better nix defaults";
  };
  config = lib.mkIf config.modules.better-nix.enable {
    nix = {
      channel.enable = false;
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "cgroups"
          "auto-allocate-uids"
        ];
        use-cgroups = true;
        auto-allocate-uids = true;
        builders-use-substitutes = true;
        warn-dirty = false;
        trusted-users = [ "@wheel" "mateidibu" ];
        allowed-users = lib.mapAttrsToList (_: u: u.name) (
          lib.filterAttrs (_: user: user.isNormalUser) config.users.users
        );
        http-connections = 0;
        max-substitution-jobs = 128;
        substituters = [
          "https://nix-community.cachix.org"
          "https://mateidibu.cachix.org"
          "https://cache.nixos.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "mateidibu.cachix.org-1:9YiZ97RR2tUHvt79sMP0oXhP+nA3OYanCs5A2/bnmAA="
        ];
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
