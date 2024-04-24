let
  device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNX0NA05054K_1";
in
{
  disko.devices = {
    disk = {
      nas = {
        inherit device;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            nas = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [
                  "--force"
                  "--checksum blake2b"
                ];
                subvolumes = {
                  "/torrents" = {
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                      "ssd"
                    ];
                    mountpoint = "/mnt/torrents";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
