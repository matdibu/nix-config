{ inputs, ... }:
let
  device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNF0M943331J_1";
in
{
  imports = [ inputs.self.nixosModules.profiles-tmpfs-root-with-swap-and-zfs ];

  boot.initrd.kernelModules = [ "nvme" ];

  disko.devices = {
    disk."root-disk".device = device;
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
}
