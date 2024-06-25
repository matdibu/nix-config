{ lib, config, ... }:
let
  cfg = config.modules.impermanence;
in
{
  config = lib.mkIf (cfg.enable && (lib.strings.hasInfix "tmpfs" cfg.type)) {
    fileSystems."/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "mode=755" ];
    };
  };
}
