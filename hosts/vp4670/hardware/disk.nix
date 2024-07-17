{inputs, ...} : 
let
      device = "/dev/disk/by-id/nvme-WDS200T1X0E-00AFY0_21469J442501_1";
    in
{
    imports = [inputs.self.nixosModules.profiles-tmpfs-root-with-swap-and-zfs];

  boot.initrd.kernelModules = [ "nvme" ];

      disko.devices = {
    disk."root-disk".device = device;
    zpool."tank".datasets = {
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
