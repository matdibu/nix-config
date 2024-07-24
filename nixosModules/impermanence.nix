{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  options = {
    modules.impermanence.enable = lib.mkEnableOption "impermanence";
  };

  config = lib.mkIf config.modules.impermanence.enable {
    # Don't allow mutation of users outside of the config.
    users.mutableUsers = false;

    boot.initrd.systemd.enable = true;

    fileSystems."/mnt/persist".neededForBoot = true;

    environment.persistence."/mnt/persist" = {
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
  };
}
