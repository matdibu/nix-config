{pkgs, ...}: let
  font_name = "FiraMono";
in {
  imports = [
    ./fonts.nix
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome.gnome-themes-extra;
      name = "Adwaita-dark";
    };
  };

  home.packages = with pkgs; [
    mako
    wl-clipboard
  ];

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "${font_name}:size=14";
      };
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      fonts = {
        names = ["${font_name}"];
        style = "Normal";
        size = 13.0;
      };
      menu = "${pkgs.wofi}/bin/wofi --show run";
      modifier = "Mod4";
    };
    extraConfig = ''
      bindsym Print               exec ${pkgs.shotman}/bin/shotman -c output
      bindsym Print+Shift         exec ${pkgs.shotman}/bin/shotman -c region
      bindsym Print+Shift+Control exec ${pkgs.shotman}/bin/shotman -c window

      output * adaptive_sync on

      xwayland disable

      # TV
      output 'LG Electronics LG TV SSCR2 0x01010101' disable

      output 'Dell Inc. DELL S2721DGF BS4J623' {
        mode 2560x1440@165Hz
        adaptive_sync on
        render_bit_depth 10
        subpixel rgb
      }
    '';
    wrapperFeatures.gtk = true;
  };
}
