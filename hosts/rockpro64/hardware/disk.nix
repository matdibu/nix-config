{
  boot.initrd.kernelModules = [
    "pcie_rockchip_host"
    "phy_rockchip_pcie"
    "sdhci_pci"
  ];

  modules = {
    impermanence = {
      enable = true;
      device = "/dev/disk/by-path/platform-fe330000.mmc";
    };
  };
}
