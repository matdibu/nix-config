{ inputs, ... }:
let
  device = "/dev/disk/by-id/usb-Samsung_Flash_Drive_FIT_0342121020007839-0:0";
in
{
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
    inputs.self.nixosModules.profiles-tmpfs-root-with-swap-and-zfs
  ];

  disko.devices = {
    disk."root-disk".device = device;
  };

  hardware.raspberry-pi."4" = {
    apply-overlays-dtmerge.enable = true;
    xhci.enable = true;
  };

  hardware.deviceTree.enable = true;

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" ];
    loader = {
      systemd-boot.enable = true;
      generic-extlinux-compatible.enable = false;
      efi.canTouchEfiVariables = false;
    };
  };

  networking.hostId = "9edbfeb9";

  systemd.network.networks = {
    "10-wan" = {
      matchConfig.Name = "end0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "no";
    };
    "20-wwan" = {
      matchConfig.Name = "wlan0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };

  networking.wireless = {
    enable = true;
    networks = {
      "dibux-legacy" = {
        psk = "okmijnqaz";
      };
    };
  };
}
