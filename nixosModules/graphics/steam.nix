{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    modules.steam.enable = lib.mkEnableOption "steam";
  };
  config = lib.mkIf config.modules.steam.enable {
    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };
}
