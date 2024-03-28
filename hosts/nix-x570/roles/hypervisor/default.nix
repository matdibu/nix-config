{ pkgs, ... }: {
  imports = [
    # ./libvirt.nix
    # ./qemu.nix
    # ./vfio.nix
    # ./zvolumes.nix
  ];

  boot.kernelModules = [ "kvm-amd" ];

  environment.systemPackages = with pkgs; [ cloud-hypervisor ];

  # boot.kernelParams = [
  #   "default_hugepagesz=1G"
  #   "hugepagesz=1G"
  #   "hugepages=20"
  # ];
}
