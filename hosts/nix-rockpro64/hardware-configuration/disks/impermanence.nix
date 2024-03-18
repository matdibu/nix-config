{inputs, ...}: let
  persist_path = "/mnt/persist";
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence.${persist_path} = {
    hideMounts = true;
    directories = [
      "/var/log"
      # "/var/lib/systemd/coredump"
    ];
    files = [
      # machine id for log continuity
      "/etc/machine-id"
    ];
  };
}
