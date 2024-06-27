{
  boot.initrd.kernelModules = [ "nvme" ];

  modules = {
    impermanence = {
      enable = true;
      type = "btrfs";
      # extraVolumes = [ "torrents" ];
      device = "/dev/disk/by-id/nvme-WDS200T1X0E-00AFY0_21469J442501_1";
    };
  };

  environment.persistence."/mnt/persist" = {
    users."mateidibu" = {
      directories = [ "git" ];
    };
  };
}
