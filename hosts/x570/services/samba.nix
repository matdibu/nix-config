{
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
    shares = {
      "torrents" = {
        "path" = "/mnt/torrents";
        "writeable" = "no";
      };
    };
  };
}
