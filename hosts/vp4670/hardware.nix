{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.protectli-vp4670
    inputs.self.nixosModules.profiles-tmpfs-root-with-swap-and-zfs
  ];

  modules = {
    gpu-intel.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  powerManagement.cpuFreqGovernor = "performance";

  boot.initrd.kernelModules = [ "nvme" ];

  disko.devices = {
    disk."root-disk".device = "/dev/disk/by-id/nvme-WDS200T1X0E-00AFY0_21469J442501_1";
    zpool."tank".datasets = {
      "system/containers" = {
        type = "zfs_fs";
        mountpoint = "/mnt/containers";
      };
      "nas" = {
        type = "zfs_fs";
      };
      "nas/junk" = {
        type = "zfs_fs";
        mountpoint = "/mnt/junk";
      };
    };
  };

  environment.persistence."/mnt/persist" = {
    users."mateidibu" = {
      directories = [ "git" ];
    };
  };

  networking.hostId = "47b6b445";

  systemd.network.networks."10-wan" = {
    matchConfig.Name = "enp1s0";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
    };
    linkConfig.RequiredForOnline = "routable";
  };
}
