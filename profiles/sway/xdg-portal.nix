{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    config = { sway.default = [ "wlr" "gtk" ]; };
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };
}
