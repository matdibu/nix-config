{
  nixpkgs.overlays = [
    (_: prev: {
      qemu_kvm = prev.qemu_kvm.overrideAttrs (_: {
        configureFlags = prev.qemu_kvm.configureFlags ++ [ "-DCONFIG_IOMMUFD" ];
      });
    })
  ];
}
