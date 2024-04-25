{ config, ... }:
{
  boot.initrd.kernelModules = [ "nvme" ];

  modules = {
    impermanence = {
      enable = true;
      type = "btrfs";
      device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNF0M943331J_1";
      extraVolumes = [
        "containers"
        "vm-storage"
      ];
    };
  };

  environment.persistence.${config.modules.impermanence.mountpoint} = {
    users."mateidibu" = {
      directories = [ "git" ];
    };
  };
}
