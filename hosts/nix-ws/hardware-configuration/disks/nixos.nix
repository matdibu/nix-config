{inputs, ...}: let
  device = "/dev/disk/by-path/virtio-pci-0000:00:07.0";
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];
  disko.devices = {
    disk = {
      "${baseNameOf device}" = {
        inherit device;
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
            nixos = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "nixos";
              };
            };
          };
        };
      };
    };
  };
}
