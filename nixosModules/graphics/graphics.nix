{ lib, config, ... }:
{
  options = {
    modules.opengl.enable = lib.mkEnableOption "OpenGL";
  };
  config = lib.mkIf config.modules.opengl.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
