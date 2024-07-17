{ pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  environment.systemPackages = builtins.attrValues { inherit (pkgs) cloud-hypervisor qemu_kvm; };

  boot = {
    initrd.kernelModules = [ "kvm-amd" ];
    kernelParams = [
      "kvm_amd.avic=1"
      "kvm_amd.npt=1"
      "kvm_amd.nested=1"
      "kvm.ignore_msrs=1"
      "kvm.report_ignored_msrs=1"
      # "amd_iommu=pgtbl_v2" # issues with kernel 6.9.0
      "amd_iommu_intr=vapic"
    ];
  };
}
