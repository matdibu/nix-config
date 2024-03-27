{
  imports = [
    ./hardware
  ];

  boot.kernelParams = [
    "iomem=relaxed"
  ];

  system.stateVersion = "24.05";
}
