{ inputs
, ...
}: {

  imports = with inputs.nixos-hardware.nixosModules;
    [
      common-cpu-intel
      common-gpu-intel
    ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "i915" ];

  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelParams = [
    "i915.enable_guc=2"
    "i915.modeset=1"
  ];
}
