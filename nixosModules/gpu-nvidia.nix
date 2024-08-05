{ lib, config, ... }:
{
  options = {
    modules.gpu-nvidia.enable = lib.mkEnableOption "Nvidia GPU";
  };

  config = lib.mkIf config.modules.gpu-nvidia.enable {
    environment.variables = {
      # Required to run the correct GBM backend for nvidia GPUs on wayland
      GBM_BACKEND = "nvidia-drm";
      # Apparently, without this nouveau may attempt to be used instead
      # (despite it being blacklisted)
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
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
