{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    modules.sway.enable = lib.mkEnableOption "sway";
  };
  config = lib.mkIf config.modules.sway.enable {
    modules = {
      xdg-portal.enable = true;
      wayland.enable = true;
    };

    programs.sway = {
      enable = true;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
      extraPackages = with pkgs; [
        wofi
        shotman
        i3status
        foot
      ];
      extraOptions = [
        "--unsupported-gpu" # nvidia
      ];
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
    };
  };
}
