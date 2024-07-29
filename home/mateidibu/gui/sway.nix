{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  # home.packages = [
  #   (pkgs.nerdfonts.override {
  #     fonts = [
  #       "FiraMono"
  #       "Cousine"
  #     ];
  #   })
  # ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
  };

  home.packages = builtins.attrValues { inherit (pkgs) mako wl-clipboard wofi; };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=14";
      };
    };
  };

  xdg.configFile."sway/config".source = ./sway.config;
}
