{
  #fonts.fontconfig.enable = true;
  #home.packages = [
  #  (pkgs.nerdfonts.override {fonts = ["FiraMono" "Cousine"];})
  #];

  #gtk = {
  #  enable = true;
  #  theme = {
  #    package = pkgs.gnome.gnome-themes-extra;
  #    name = "Adwaita-dark";
  #  };
  #};

  environment.sessionVariables = {
    # Set wlroots renderer to Vulkan to avoid flickering
    WLR_RENDERER = "vulkan";
    # Hardware cursors not yet working on wlroots
    WLR_NO_HARDWARE_CURSORS = "1";

    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";

    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    _JAVA_AWT_WM_NONREPARENTING = "1";

    # Firefox wayland environment variable
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";

    NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";

    # Xwayland compatibility
    XWAYLAND_NO_GLAMOR = "1";

    GBM_BACKEND = "nvidia-drm";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  programs.xwayland.enable = false;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
