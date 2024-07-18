{ lib, ... }:
let
  pciIDs = [
    # RTX 3080 LHR
    "10de:2216" # VGA
    "10de:1aef" # Audio

    # Realtek RTL8111 IPMI
    "10ec:8168" # Ethernet controller
    "10ec:816a" # Serial
    "10ec:816c" # IPMI
    "10ec:816d" # IPMI
    "10ec:816e" # BMC

    # USB
    "1022:149c" # AMD Matisse USB 3.0 Host Controller
    # Same IOMMU group as USB
    "1022:1485" # Starship/Matisse Reserved SPP
  ];
in
{
  boot = {
    blacklistedKernelModules = [
      # blacklist USB 3.0 module because it was binding to the device before vfio_pci
      "xhci_pci"
    ];
    initrd.kernelModules = [
      "vfio"
      "vfio_pci"
    ];
    kernelParams = [
      "default_hugepagesz=1G"
      "hugepagesz=1G"
      "hugepages=32"
      ("vfio_pci.ids=" + lib.concatStringsSep "," pciIDs)
    ];
  };
}
