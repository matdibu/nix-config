{ inputs, config, ... }:
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
    xhci.enable = false; # "true" breaks the kernel build
  };

  hardware.deviceTree.enable = true;

  boot = {
    initrd = {
      # availableKernelModules = [ "xhci_pci" ]; # USB3 seems to be unstable
      systemd.enableTpm2 = false; # "true" breaks the kernel build
    };
    loader = {
      systemd-boot.enable = true;
      generic-extlinux-compatible.enable = false;
      efi.canTouchEfiVariables = false;
    };
    kernelParams = [ "brcmfmac.feature_disable=0x82000" ];
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

  hardware.wirelessRegulatoryDatabase = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="RO"
    options brcmfmac feature_disable=0x82000
  '';

  sops.secrets."wifi/dibux-legacy/password" = { };

  networking.wireless = {
    enable = true;
    environmentFile = config.sops.secrets."wifi/dibux-legacy/password".path;
    networks = {
      "dibux-legacy" = {
        psk = "@dibux-legacy_psk@";
      };
    };
  };

  hardware.deviceTree = {
    filter = "*-rpi-*.dtb";
    overlays = [
      {
        name = "disable-bt";
        dtboFile = ./disable-bt.dtbo;
      }
    ];
  };
}
