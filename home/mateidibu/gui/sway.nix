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

  home.sessionVariables = {
    # Set wlroots renderer to Vulkan to avoid flickering
    WLR_RENDERER = "vulkan";
    # Hardware cursors not yet working on wlroots
    WLR_NO_HARDWARE_CURSORS = "1";

    # Chromium/Electron
    NIXOS_OZONE_WL = "1";

    SDL_VIDEODRIVER = "wayland";

    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    _JAVA_AWT_WM_NONREPARENTING = "1";

    # Xwayland compatibility
    XWAYLAND_NO_GLAMOR = "1";

    GBM_BACKEND = "nvidia-drm";
    __GL_GSYNC_ALLOWED = "0";
    # __GL_VRR_ALLOWED = "0";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
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

      # TV
      output 'LG Electronics LG TV SSCR2 0x01010101' disable

      output 'Dell Inc. DELL S2721DGF BS4J623' {
        mode 2560x1440@165Hz
        # adaptive_sync on
        # render_bit_depth 10
        subpixel rgb
      }
    '';
    wrapperFeatures.gtk = true;
  };
}
