{ lib, config, ... }:
let
  cfg = config.modules.smb-share;
in
{
  options = {
    modules.smb-share.enable = lib.mkEnableOption "smb network share";
  };
  config = lib.mkIf cfg.enable {
    networking.firewall.allowPing = true;

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    services.samba = {
      enable = true;
      openFirewall = true;
      extraConfig = ''
        min protocol = smb3_11
        guest ok = yes
        guest only = yes
      '';
      # # example:
      # shares = {
      #   "torrents" = {
      #     "path" = "/mnt/torrents";
      #     "writeable" = "no";
      #   };
      # };
    };

  };
}
