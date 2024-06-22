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
    image = "ghcr.io/jellyfin/jellyfin@sha256:5a60ca20d4b35e0f3c71c67893bfdae52eaf90f5219155d7a6a7f771105d6263";
    volumes = [
      "/mnt/containers/jellyfin/cache:/cache:rw"
      "/mnt/containers/jellyfin/config:/config:rw"
      "/mnt/containers/jellyfin/media:/media:ro"
    ];
    extraOptions = [ "--network=host" ];
  };
}
