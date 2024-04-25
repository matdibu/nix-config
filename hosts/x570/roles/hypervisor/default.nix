{ pkgs, ... }:
{
  imports = [
    ./libvirt.nix
    ./vfio.nix
  ];

  boot.kernelModules = [ "kvm-amd" ];

  environment.systemPackages = with pkgs; [
    cloud-hypervisor
    qemu_kvm
  ];

  boot.kernelParams = [
    "kvm_amd.avic=1"
    "kvm_amd.npt=1"
    "kvm_amd.nested=1"
    "kvm_amd.sev=0" # negative performance impact when enabled
    "kvm.ignore_msrs=1"
    "kvm.report_ignored_msrs=1"
    # "default_hugepagesz=1G"
    # "hugepagesz=1G"
    # "hugepages=20"
  ];
}
