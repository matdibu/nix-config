{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixos-hardware.nixosModules.raspberry-pi-4 ];

  hardware.raspberry-pi."4" = {
    apply-overlays-dtmerge.enable = true;
    # fkms-3d.enable = true;
    xhci.enable = true;
  };

  hardware.deviceTree = {
    enable = true;
    # filter = "*rpi-4-*.dtb";
  };

  boot = {
    # kernelPackages = pkgs.linuxPackages_rpi4;
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.availableKernelModules = [ "xhci_pci" ];
    loader = {
      systemd-boot.enable = true;
      generic-extlinux-compatible.enable = false;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostId = "9edbfeb9";

  systemd.network.networks."10-wan" = {
    matchConfig.Name = "end0";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
    };
    linkConfig.RequiredForOnline = "routable";
  };
}
