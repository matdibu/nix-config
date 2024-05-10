{ lib, ... }:
{
  boot.kernelPatches = [
    {
      name = "Enable staging drivers";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        STAGING = y;
        STAGING_MEDIA = y;
      };
    }
    {
      name = "GPU - 4 x Mali-T860";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        DRM_ROCKCHIP = y;
        DRM_PANFROST = y;
        ROCKCHIP_IOMMU = y;
      };
    }
    {
      name = "HDMI";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        ROCKCHIP_VOP = y;
        ROCKCHIP_VOP2 = y;
        ROCKCHIP_DW_HDMI = y;
      };
    }
    {
      name = "MMC";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        MMC_DW_ROCKCHIP = y;
        PWRSEQ_EMMC = y;
      };
    }
    {
      name = "SDHCI";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        MMC_SDHCI_OF_ARASAN = y;
      };
    }
    {
      name = "Ethernet MAC";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        DWMAC_ROCKCHIP = y;
        EMAC_ROCKCHIP = y;
      };
    }
    {
      name = "USB Type-C";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        TYPEC_FUSB302 = y;
      };
    }
    {
      name = "USB Type-A 3.0";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        USB_XHCI_PLATFORM = y;
      };
    }
    {
      name = "USB Type-A 2.0";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        USB_EHCI_HCD_PLATFORM = y;
      };
    }
    {
      name = "DMA engine";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        PL330_DMA = y;
      };
    }
    {
      name = "HDMI audio";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        SND_SOC_ROCKCHIP = y;
        SND_SOC_ROCKCHIP_I2S = y;
        SND_SOC_ROCKCHIP_I2S_TDM = y;
        DRM_DW_HDMI_I2S_AUDIO = y;
        SND_SIMPLE_CARD = y;
      };
    }
    {
      name = "Power management";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        MFD_RK808 = y;
        MFD_RK8XX_I2C = y;
        MFD_RK8XX_SPI = y;
        MFD_RK8XX = y;
        REGULATOR_RK808 = y;
        ROCKCHIP_DTPM = y;
      };
    }
    {
      name = "Mailbox";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        ARM_SCPI_PROTOCOL = y;
        MAILBOX = y;
        ROCKCHIP_MBOX = y;
      };
    }
    {
      name = "Hantro VPU";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        VIDEO_HANTRO = y;
        VIDEO_HANTRO_ROCKCHIP = y;
      };
    }
    {
      name = "Other devices";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        CLK_RK3399 = y;
        CRYPTO_DEV_ROCKCHIP = y;
        DEVFREQ_EVENT_ROCKCHIP_DFI = y;
        I2C_RK3X = y;
        MTD_NAND_ROCKCHIP = y;
        PHY_ROCKCHIP_TYPEC = y;
        PHY_ROCKCHIP_USB = y;
        ROCKCHIP_IODOMAIN = y;
        ROCKCHIP_LVDS = y;
        ROCKCHIP_PHY = y;
        ROCKCHIP_RGB = y;
        ROCKCHIP_SARADC = y;
        ROCKCHIP_THERMAL = y;
        RTC_DRV_RK808 = y;
        SPI_ROCKCHIP = y;
        VIDEO_ROCKCHIP_ISP1 = y;
        VIDEO_ROCKCHIP_RGA = y;
        VIDEO_ROCKCHIP_VDEC = y;
      };
    }
  ];

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
