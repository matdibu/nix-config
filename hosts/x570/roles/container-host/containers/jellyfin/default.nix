{
  imports = [ ./auto-generated.nix ];

  # https://jellyfin.org/docs/general/networking/
  networking.firewall = {
    allowedTCPPorts = [
      8096 # HTTP
      8920 # HTTPS
    ];
    allowedUDPPorts = [
      1900 # service auto-discovery
      7359 # service auto-discovery
    ];
  };

  fileSystems."/mnt/containers/jellyfin/media" = {
    device = "/mnt/torrents";
    options = [ "bind" ];
  };
}
