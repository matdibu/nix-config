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
in { lib, ... }: {
  boot = {
    initrd.kernelModules = [ "vfio" "vfio_pci" ];

    kernelParams = [
      "amd_iommu=pgtbl_v2"
      "amd_iommu_intr=vapic"
      ("vfio-pci.ids=" + lib.concatStringsSep "," pciIDs)
    ];
  };
}
