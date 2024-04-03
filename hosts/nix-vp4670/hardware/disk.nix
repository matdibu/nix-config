{ config, ... }:
{
  boot.initrd.kernelModules = [
    "sdhci_pci"
    "nvme"
  ];

  modules = {
    impermanence = {
      enable = true;
      device = "/dev/disk/by-id/nvme-WDS200T1X0E-00AFY0_21469J442501";
    };
  };

  environment.persistence.${config.modules.impermanence.mountpoint} = {
    users."mateidibu" = {
      directories = [ "git" ];
    };
  };
}
