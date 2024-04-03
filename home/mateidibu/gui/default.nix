{ pkgs, ... }:
{
  imports = [
    ./sway.nix # config only
    ./librewolf.nix
  ];

  home.packages = with pkgs; [ telegram-desktop ];
}
