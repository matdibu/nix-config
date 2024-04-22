{ config, ... }:
{
  boot.initrd.kernelModules = [ "nvme" ];

  modules = {
    impermanence-btrfs = {
      enable = true;
      device = "/dev/disk/by-id/nvme-WDS200T1X0E-00AFY0_21469J442501_1";
    };
  };

  environment.persistence.${config.modules.impermanence.mountpoint} = {
    users."mateidibu" = {
      directories = [ "git" ];
    };
  };
}
