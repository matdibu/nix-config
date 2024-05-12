{ pkgs, ... }:
{
  imports = [
    ./sway.nix # config only
    ./librewolf.nix
  ];

  home.packages = builtins.attrValues { inherit (pkgs) telegram-desktop; };
}
