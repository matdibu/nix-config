{ lib, config, pkgs, ... }:
{
  options = {
    modules.gpu-nvidia.enable = lib.mkEnableOption "Nvidia GPU";
  };

  config = lib.mkIf config.modules.gpu-nvidia.enable {
    hardware.opengl.extraPackages = builtins.attrValues {
      inherit (pkgs) nvidia-vaapi-driver vaapiVdpau;
    };

    environment.variables = {
      # Necessary to correctly enable va-api (video codec hardware
      # acceleration). If this isn't set, the libvdpau backend will be
      # picked, and that one doesn't work with most things, including
      # Firefox.
      LIBVA_DRIVER_NAME = "nvidia";
      # Required to run the correct GBM backend for nvidia GPUs on wayland
      GBM_BACKEND = "nvidia-drm";
      # Apparently, without this nouveau may attempt to be used instead
      # (despite it being blacklisted)
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      # # Required to use va-api it in Firefox. See
      # # https://github.com/elFarto/nvidia-vaapi-driver/issues/96
      # MOZ_DISABLE_RDD_SANDBOX = "1";
      # It appears that the normal rendering mode is broken on recent
      # nvidia drivers:
      # https://github.com/elFarto/nvidia-vaapi-driver/issues/213#issuecomment-1585584038
      NVD_BACKEND = "direct";
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    boot.kernelParams = lib.mkBefore [ "nvidia_drm.fbdev=1" ];

    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
}
