{ pkgs
, lib
, config
, ...
}: {
  options = {
    modules.gpu-intel.enable = lib.mkEnableOption "Intel GPU";
  };
  config = lib.mkIf config.modules.gpu-intel.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [
        # VA-API
        pkgs.intel-media-driver
        # OpenCL
        # pkgs.intel-compute-runtime
        # VDPAU
        # pkgs.vaapiVdpau
        # pkgs.libvdpau-va-gl
      ];
    };

    services.xserver.videoDrivers = [ "modesetting" ];

    boot.initrd.kernelModules = [ "i915" ];
    boot.kernelParams = [
      "i915.enable_guc=3"
      "i915.modeset=1"
    ];
  };
}
