{ inputs, ... }:
{
  imports = [ inputs.nixos-hardware.nixosModules.raspberry-pi-4 ];

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
      # linkConfig.RequiredForOnline = "routable";
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
        pskRaw = "499f3e627ab6d43ed8ed2dfe13c2fc790a1d88000d064399a0c7352b583ea44f";
        authProtocols = [ "WPA-PSK-SHA256" ];
      };
    };
  };
}
