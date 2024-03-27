{ pkgs, ... }: {
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

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "wlr" "gtk" ];
      sway.default = [ "wlr" "gtk" ];
    };
    configPackages = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  home.sessionVariables = {
    # GBM_BACKEND="nvidia-drm";
    # __GL_GSYNC_ALLOWED="0";
    # __GL_VRR_ALLOWED="0";
    # __GLX_VENDOR_LIBRARY_NAME="nvidia";
  };

  home.packages = with pkgs; [
    mako
    wl-clipboard
  ];

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=14";
      };
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    xwayland = false;
    config = {
      fonts = {
        names = [ "monospace" ];
        style = "Normal";
        size = 13.0;
      };
      menu = "${pkgs.wofi}/bin/wofi --show run";
      modifier = "Mod4";
    };
    extraOptions = [
      "--unsupported-gpu"
    ];
    extraConfig = ''
      bindsym Print               exec ${pkgs.shotman}/bin/shotman -c output
      bindsym Print+Shift         exec ${pkgs.shotman}/bin/shotman -c region
      bindsym Print+Shift+Control exec ${pkgs.shotman}/bin/shotman -c window

      output * adaptive_sync on

      xwayland disable

      output 'LG Electronics LG TV SSCR2 0x01010101' disable

      output 'Dell Inc. DELL S2721DGF BS4J623' {
        mode 2560x1440@165Hz
        # adaptive_sync on
        # render_bit_depth 10
        subpixel rgb
      }
    '';
    extraSessionCommands = ''
      # Set wlroots renderer to Vulkan to avoid flickering
      export WLR_RENDERER="vulkan";
      # Hardware cursors not yet working on wlroots
      export WLR_NO_HARDWARE_CURSORS="1";

      # Chromium/Electron
      export NIXOS_OZONE_WL="1";

      export SDL_VIDEODRIVER="wayland";

      export QT_QPA_PLATFORM="wayland";
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1";

      export _JAVA_AWT_WM_NONREPARENTING="1";

      # Xwayland compatibility
      export XWAYLAND_NO_GLAMOR="1";
    '';
    wrapperFeatures.gtk = true;
  };
}
