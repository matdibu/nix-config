{
  imports = [
    ./libvirt.nix
    # ./cloud-hypervisor.nix
    ./qemu.nix
    ./vfio.nix
    ./zvolumes.nix
  ];

  boot.kernelModules = [ "kvm-amd" ];

  boot.kernelParams = [
    "default_hugepagesz=1G"
    "hugepagesz=1G"
    "hugepages=20"
  ];
}
