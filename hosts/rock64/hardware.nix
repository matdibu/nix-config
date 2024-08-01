{ inputs, ... }:
{
  imports = [
    # inputs.nixos-hardware.nixosModules."pine64-rock64" # does not exist, yet
    inputs.self.nixosModules.profiles-tmpfs-root-with-swap-and-zfs
  ];

  modules = {
    smartd.enable = false;
  };

  # not using tow-boot, yet
  boot.loader = {
    # systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  boot.initrd.kernelModules = [
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
    "sdhci_pci"
  ];

  disko.devices = {
    disk."root-disk".device = "/dev/disk/by-path/platform-ff520000.mmc";
  };

  networking.hostId = "465ea088";

  systemd.network.networks."10-wan" = {
    matchConfig.Name = "end0";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
    };
    linkConfig.RequiredForOnline = "routable";
  };
}
