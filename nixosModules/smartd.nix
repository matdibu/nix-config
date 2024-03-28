{ lib, config, ... }: {
  options = {
    modules.smartd.enable = lib.mkEnableOption "smartd monitoring and alerts"
      // {
        default = true;
      };
  };
  config = lib.mkIf config.modules.smartd.enable {
    services.smartd = {
      enable = true;
      notifications = {
        mail = {
          enable = true;
          sender = "root@nix-hv.net";
          recipient = "contact+nix-hv@mateidibu.dev";
        };
      };
      defaults.autodetected = "-a -o on -s (S/../../3/12|L/../01/./17)";
    };
  };
}
