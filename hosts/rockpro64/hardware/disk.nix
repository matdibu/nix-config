{ inputs, ... }:
let
  device = "/dev/disk/by-path/platform-fe330000.mmc";
in
{
  imports = [ inputs.self.nixosModules.profiles-tmpfs-root-with-swap-and-zfs ];

  boot.initrd.kernelModules = [
    "pcie_rockchip_host"
    "phy_rockchip_pcie"
    "sdhci_pci"
  ];

  disko.devices = {
    disk."root-disk".device = device;
  };
}
