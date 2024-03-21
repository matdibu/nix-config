_: let
  persist_path = "/mnt/persist";
in {
  imports = [
    # inputs.impermanence.nixosModules.impermanence
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
