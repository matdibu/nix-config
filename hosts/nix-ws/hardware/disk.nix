{ config, ... }: {
  modules.impermanence = {
    enable = true;
    device = "/dev/disk/by-path/virtio-pci-0000:00:07.0";
  };

  environment.persistence.${config.modules.impermanence.mountpoint} = {
    users."mateidibu" = { directories = [ "git" ]; };
  };
}
