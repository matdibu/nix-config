{ lib, config, ... }: {
  options = { modules.wayland.enable = lib.mkEnableOption "wayland"; };
  config = lib.mkIf config.modules.wayland.enable {

    modules.opengl.enable = true;

    environment.variables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      EGL_PLATFORM = "wayland";
      # __GL_GSYNC_ALLOWED = "0";
      # __GL_VRR_ALLOWED = "0";
    };
  };
}
