{pkgs, ...}: {
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
        font = "monospace:size=14";
      };
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
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
    extraOptions = [
      "--unsupported-gpu"
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
      export WLR_NO_HARDWARE_CURSORS=1

      export NVD_BACKEND=direct
      export MOZ_DISABLE_RDD_SANDBOX=1
      export LIBVA_DRIVER_NAME=nvidia
    '';
    wrapperFeatures.gtk = true;
  };
}
