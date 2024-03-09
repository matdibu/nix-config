{inputs, ...}: let
  persist_path = "/mnt/persist";
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  # set machine id for log continuity
  environment.etc.machine-id.source = ./machine-id;

  environment.persistence.${persist_path} = {
    hideMounts = true;
    directories = [
      "/var/log"
      # "/var/lib/systemd/coredump"
      # "/tmp" # Make builds not crash by running them on disk instead of RAM (We still clean /tmp on boot)
    ];
  };
}
