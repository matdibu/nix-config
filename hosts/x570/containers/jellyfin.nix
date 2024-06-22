{
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

  virtualisation.oci-containers.containers."jellyfin" = {
    image = "ghcr.io/jellyfin/jellyfin:2024061705";
    volumes = [
      "/mnt/containers/jellyfin/cache:/cache:rw"
      "/mnt/containers/jellyfin/config:/config:rw"
      "/mnt/containers/jellyfin/media:/media:ro"
    ];
    user = "0:0";
    extraOptions = [ "--network=host" ];
  };
}