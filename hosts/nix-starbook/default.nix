{
  imports = [ ./hardware ];

  modules.sway.enable = true;

  #programs.sway = {
  #  enable = true;
  #  wrapperFeatures = {
  #    base = true;
  #    gtk = true;
  #  };
  #  extraPackages = with pkgs; [
  #    i3status
  #    i3status-rust
  #    rofi
  #    light
  #    foot
  #    dmenu
  #    wofi
  #  ];
  #  extraSessionCommands = ''
  #    # Set wlroots renderer to Vulkan to avoid flickering
  #    export WLR_RENDERER="vulkan";
  #    # Hardware cursors not yet working on wlroots
  #    export WLR_NO_HARDWARE_CURSORS="1";

  #    # Chromium/Electron
  #    export NIXOS_OZONE_WL="1";

  #    export SDL_VIDEODRIVER="wayland";

  #    export QT_QPA_PLATFORM="wayland";
  #    export QT_WAYLAND_DISABLE_WINDOWDECORATION="1";

  #    export _JAVA_AWT_WM_NONREPARENTING="1";

  #    # Xwayland compatibility
  #    export XWAYLAND_NO_GLAMOR="1";
  #  '';

  #};

  #xdg = {
  #  portal = {
  #    enable = true;
  #    wlr.enable = true;
  #    xdgOpenUsePortal = true;
  #    extraPortals = with pkgs; [
  #      xdg-desktop-portal-wlr
  #      xdg-desktop-portal-gtk
  #    ];
  #    gtkUsePortal = true;
  #    config = {
  #      common = {
  #        default = [
  #          "wlr"
  #          "gtk"
  #        ];
  #      };
  #    };
  #  };
  #};

  services.upower.enable = true;

  system.stateVersion = "24.05";
}
