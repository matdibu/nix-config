{
  # imports = [ ./kernel-patches.nix ];

  boot.initrd.kernelModules = [
    # Mali-T860 GPU
    "panfrost"
    "rockchipdrm"

    "pcie_rockchip_host"
    "phy_rockchip_pcie"
    "rockchip_dfi"
    "rockchip_rga"
    "rockchip_isp1"
    "rockchip_saradc"
    "rockchip_thermal"
    "rockchip_vdec"
    "snd_soc_rockchip_i2s"
    # "clk_rk3399"
    "rk_crypto"

    "dwmac_rk"
    "rk3399_dmc"

    "v4l2_h264"
    "v4l2_mem2mem"
    "v4l2_vp9"
  ];
}
