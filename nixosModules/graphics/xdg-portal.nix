{ pkgs, lib, config, ... }: {
  options = {
    modules.xdg-portal.enable = lib.mkEnableOption "xdg-desktop-portal";
  };
  config = lib.mkIf config.modules.xdg-portal.enable {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      wlr.enable = true;
      config = { sway.default = [ "wlr" "gtk" ]; };
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
  };
}
