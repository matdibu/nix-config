{ pkgs, ... }:
{
  imports = [
    ./sway.nix
    ./librewolf.nix
  ];

  home.packages = builtins.attrValues { inherit (pkgs) telegram-desktop super-slicer-beta; };
}
