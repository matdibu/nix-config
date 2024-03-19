{inputs, ...}: let
  hw-modules = inputs.nixos-hardware.nixosModules;
in {
  imports = [
    hw-modules."pine64-pinebook-pro"
    ./disks
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  hardware.enableAllFirmware = true;

  boot.initrd.kernelModules = [
    "pcie_rockchip_host"
    "phy_rockchip_pcie"
    "rockchip_dfi"
    "rockchipdrm"
    "rockchip_rga"
    "rockchip_saradc"
    "rockchip_thermal"
    "rockchip_vdec"
    "snd_soc_rockchip_i2s"

    "dwmac_rk"
    "rk3399_dmc"

    "v4l2_h264"
    "v4l2_mem2mem"
    "v4l2_vp9"
  ];

  nixpkgs.hostPlatform = "aarch64-linux";
}
