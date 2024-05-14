{ pkgs, ... }:
{
  imports = [
    ./libvirt.nix
    ./vfio.nix
  ];

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) cloud-hypervisor rust-hypervisor-firmware qemu_kvm;
  };

  boot = {
    initrd.kernelModules = [ "kvm-amd" ];

    blacklistedKernelModules = [
      # blacklist USB 3.0 module because it was binding to the device before vfio_pci
      "xhci_pci"
    ];

    kernelParams = [
      "kvm_amd.avic=1"
      # "kvm_amd.npt=1"    # default 1
      # "kvm_amd.nested=1" # default 1
      # "kvm_amd.sev=0"    # negative performance impact when enabled
      "kvm.ignore_msrs=1"
      "kvm.report_ignored_msrs=1"
      # "amd_iommu=pgtbl_v2" # issues with kernel 6.9.0
      "amd_iommu_intr=vapic"
      # "default_hugepagesz=1G"
      # "hugepagesz=1G"
      # "hugepages=20"
    ];
  };
}
