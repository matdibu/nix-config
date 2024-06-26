{ pkgs, ... }:
{
  imports = [ ./fonts.nix ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome.gnome-themes-extra;
      name = "Adwaita-dark";
    };
  };

  # xdg.portal = {
  #   enable = true;
  #   xdgOpenUsePortal = true;
  #   config = {
  #     common.default = [
  #       "wlr"
  #       "gtk"
  #     ];
  #     sway.default = [
  #       "wlr"
  #       "gtk"
  #     ];
  #   };
  #   configPackages = builtins.attrValues {
  #     inherit (pkgs) xdg-desktop-portal-wlr xdg-desktop-portal-gtk;
  #   };
  #   extraPortals = builtins.attrValues {
  #     inherit (pkgs) xdg-desktop-portal-wlr xdg-desktop-portal-gtk;
  #   };
  # };

  home.packages = builtins.attrValues { inherit (pkgs) mako wl-clipboard; };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=14";
      };
    };
  };

  # xdg.configFile."sway/config".source = ./sway.config;

  wayland.windowManager.sway = {
    enable = true;
    package = null; # use NixOS package
    systemd.enable = true;
    config = {
      fonts = {
        names = [ "monospace" ];
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

      # xwayland disable

      output 'LG Electronics LG TV SSCR2 0x01010101' disable

      output 'Dell Inc. DELL S2721DGF BS4J623' {
        mode 2560x1440@165Hz
        adaptive_sync on
        render_bit_depth 10
        subpixel rgb
      }
    '';
  };
}
