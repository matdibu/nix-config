{ pkgs, ... }:
{
  imports = [
    # ./libvirt.nix
    # ./qemu.nix
    # ./vfio.nix
    # ./zvolumes.nix
  ];

  boot.kernelModules = [ "kvm-amd" ];

  environment.systemPackages = with pkgs; [ cloud-hypervisor ];

  boot.kernelParams = [
    "kvm_amd.avic=1"
    "kvm_amd.npt=1"
    "kvm_amd.nested=1"
    # "kvm_amd.sev=1"
    "kvm.ignore_msrs=1"
    "kvm.report_ignored_msrs=1"
  ];

  # boot.kernelParams = [
  #   "default_hugepagesz=1G"
  #   "hugepagesz=1G"
  #   "hugepages=20"
  # ];
}
