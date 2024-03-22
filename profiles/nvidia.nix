{ inputs
, lib
, config
, ...
}: {

  imports = with inputs.nixos-hardware.nixosModules; [
    common-gpu-nvidia-nonprime
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  nixpkgs.config.allowUnfree = true;

  boot.kernelParams = lib.mkBefore [
    "nvidia_drm.fbdev=1"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
