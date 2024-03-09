{
  lib,
  inputs,
  ...
}: let
  path_persist = "/mnt/persist";
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r ephemeral/root@blank
  '';

  # Don't allow mutation of users outside of the config.
  users.mutableUsers = false;

  # set machine id for log continuity
  # environment.etc.machine-id.source = ./machine-id;
  environment.etc.machine-id.text = "13cd9534398b4629bda48ec4f8683295";

  fileSystems.${path_persist}.neededForBoot = true;
  environment.persistence.${path_persist} = {
    hideMounts = true;
    directories = [
      "/var/log"
    ];
    files = [
    ];
  };

  services.openssh = {
    hostKeys = [
      {
        path = "${path_persist}/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "${path_persist}/ssh/ssh_host_rsa_key";
        type = "rsa";
        # bits=4096; # not impermanence-relevant
      }
    ];
  };
}
