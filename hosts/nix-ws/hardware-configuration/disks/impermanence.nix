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
      # "/tmp" # Make builds not crash by running them on disk instead of RAM (We still clean /tmp on boot)
    ];
    files = [
      # machine id for log continuity
      "/etc/machine-id"
    ];
    users."mateidibu" = {
      directories = [
        "git"
      ];
      files = [
        ".ssh/id_ed25519"
        ".ssh/id_ed25519.pub"
      ];
    };
  };
}
