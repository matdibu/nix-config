{ lib, config, ... }: {
  options = { modules.opengl.enable = lib.mkEnableOption "OpenGL"; };
  config = lib.mkIf config.modules.opengl.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
