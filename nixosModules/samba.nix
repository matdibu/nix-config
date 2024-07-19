{ lib, config, ... }:
{
  options = {
    modules.smb-share.enable = lib.mkEnableOption "smb network share";
  };

  config = lib.mkIf config.modules.smb-share.enable {
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
