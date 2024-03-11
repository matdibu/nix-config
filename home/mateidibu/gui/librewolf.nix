{
  home.sessionVariables = {
    # Firefox wayland environment variable
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    # MOZ_DISABLE_RDD_SANDBOX = "1";

    # NVD_BACKEND = "direct";
    # LIBVA_DRIVER_NAME = "nvidia";
  };
  programs.librewolf = {
    enable = true;
    #settings = {
    #  "dom.webgpu.enabled" = true;
    #  "dom.webgpu.workers.enabled" = true;
    #  "webgl.disabled" = false;
    #  "media.ffmpeg.vaapi.enabled" = true;
    #  "media.rdd-ffmpeg.enabled" = true;
    #  "media.av1.enabled" = true;
    #  "media.hardware-video-decoding.force-enabled" = true;
    #  "gfx.webgpu.ignore-blocklist" = true;
    #  "gfx.webrender.all" = true;
    #  "gfx.webrender.compositor" = true;
    #  "gfx.webrender.compositor.force-enabled" = true;
    #  "gfx.x11-egl.force-enabled" = true;
    #  "layers.acceleration.force-enabled" = true;
    #  "webgl.force-enabled" = true;
    #  "widget.dmabuf.force-enabled" = true;
    #  "widget.wayland.opaque-region.enabled" = false;
    #  "privacy.resistFingerprinting" = false;
    #  "privacy.clearOnShutdown.history" = false;
    #  "privacy.clearOnShutdown.cookies" = false;
    #  "network.cookie.lifetimePolicy" = 0;
    #};
  };
}
