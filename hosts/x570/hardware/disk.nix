{ inputs, ... }:
{
  imports = [ inputs.self.nixosModules.profiles-tmpfs-root-with-swap-and-zfs ];

  boot.initrd.kernelModules = [ "nvme" ];

  disko.devices = {
    disk."root-disk".device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNF0M943331J_1";
    zpool."tank".datasets = {
      "system/vm-storage" = {
        type = "zfs_fs";
        mountpoint = "/mnt/vm-storage";
      };
      "system/containers" = {
        type = "zfs_fs";
        mountpoint = "/mnt/containers";
      };
    };
  };

  environment.persistence."/mnt/persist" = {
    users."mateidibu" = {
      directories = [ "git" ];
    };
  };
}
