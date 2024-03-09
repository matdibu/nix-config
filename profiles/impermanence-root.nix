{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./zfs.nix
./zfs-volumes.nix
  ];
  disko.devices = {
    nodev."/" = {
fsType = "tmpfs";
          mountOptions = [
            "mode=755"
             "noatime"
          ];
};
    disk = {
      "root" = {
        # inherit device;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0137"
                  "dmask=0027"
                  "noatime"
                ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "tank";
              };
            };
          };
        };
      };
    };
  };
}
