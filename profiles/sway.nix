{pkgs, ...}: {
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
    NIXOS_OZONE_WL = "1";
    WLR_RENDERER = "vulkan";
  };

  programs.xwayland.enable = false;

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      mako
      wl-clipboard
      wofi
      shotman
    ];
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
