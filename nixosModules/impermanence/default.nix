{ lib, config, ... }:
let
  cfg = config.modules.impermanence;
in
{
  imports = [
    ./btrfs.nix
    ./zfs.nix
  ];

  options = {
    modules.impermanence = {
      enable = lib.mkEnableOption "impermanence";
      type = lib.mkOption {
        type = lib.types.enum [
          "zfs"
          "btrfs"
        ];
      };
      device = lib.mkOption { type = lib.types.str; };
      mountpoint = lib.mkOption {
        type = lib.types.str;
        default = "/mnt/persist";
      };
      extraVolumes = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
      disko-devices = lib.mkOption { internal = true; };
      poolName = lib.mkOption {
        type = lib.types.str;
        default = "tank";
        # internal = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Don't allow mutation of users outside of the config.
    users.mutableUsers = false;

    boot = {
      initrd = {
        supportedFilesystems = [ cfg.type ];
        systemd.enable = true;
      };
      supportedFilesystems = [ cfg.type ];
    };

    fileSystems.${cfg.mountpoint}.neededForBoot = true;

    environment.persistence.${cfg.mountpoint} = {
      # hideMounts = true;
      files = lib.mkMerge [
        (lib.mkIf config.services.openssh.enable [
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_rsa_key"
        ])
        [ "/etc/machine-id" ]
      ];
      directories = [ "/var/log" ];
    };

    disko.devices = lib.attrsets.recursiveUpdate cfg.disko-devices {
      disk = {
        "root-impermanence" = {
          inherit (cfg) device;
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                size = "500M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  extraArgs = [ "-F32" ];
                  mountpoint = "/boot";
                  mountOptions = [
                    "fmask=0137"
                    "dmask=0027"
                    "noatime"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}
