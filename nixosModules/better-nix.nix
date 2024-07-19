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
        options = "--delete-older-than 7d";
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
        allowed-users = [ "mateidibu" ];
        trusted-users = [ "mateidibu" ];
        substituters = [ "https://nix-community.cachix.org" ];
        trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
