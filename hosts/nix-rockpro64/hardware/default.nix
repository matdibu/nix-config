{ inputs, ... }:
let
  hw-modules = inputs.nixos-hardware.nixosModules;
in
{
  imports = [
    hw-modules."pine64-pinebook-pro"
    ./networking.nix
    ./disk.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  boot.initrd.kernelModules = [
    # list obtained by running 'lsmod' while running the installer ISO
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
}
