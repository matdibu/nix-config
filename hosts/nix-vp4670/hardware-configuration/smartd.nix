{
  services.smartd = {
    enable = true;
    notifications = {
      mail = {
        enable = true;
        sender = "root@nix-vp4670.net";
        recipient = "contact+nix-hv@mateidibu.dev";
      };
    };
    defaults.autodetected = "-a -o on -s (S/../../3/12|L/../01/./17)";
  };
}
