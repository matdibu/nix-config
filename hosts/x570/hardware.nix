{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-pro-ws-x570-ace
    inputs.self.nixosModules.profiles-tmpfs-root-with-swap-and-zfs
  ];

  modules = {
    gpu-nvidia.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware.rasdaemon.enable = true;

  boot.initrd.kernelModules = [ "nvme" ];

  disko.devices = {
    disk."root-disk".device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNF0M943331J_1";
    zpool."tank".datasets = {
      "system/vm-storage" = {
        type = "zfs_fs";
        mountpoint = "/mnt/vm-storage";
      };
    };
  };

  environment.persistence."/mnt/persist" = {
    users."mateidibu" = {
      directories = [ "git" ];
    };
  };

  networking.hostId = "6c2854ca";

  systemd.network.networks."10-wan" = {
    matchConfig.Name = "enp5s0";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
      MulticastDNS = true;
    };
    linkConfig.RequiredForOnline = "routable";
  };
}
