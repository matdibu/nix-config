let
  version = "sha256:5a60ca20d4b35e0f3c71c67893bfdae52eaf90f5219155d7a6a7f771105d6263";
in
{
  fileSystems."/mnt/containers/jellyfin/media" = {
    device = "/mnt/persist/torrents";
    options = [ "bind" ];
  };

  virtualisation.oci-containers.containers."jellyfin" = {
    image = "ghcr.io/jellyfin/jellyfin@${version}";
    volumes = [
      "/mnt/containers/jellyfin/cache:/cache:rw"
      "/mnt/containers/jellyfin/config:/config:rw"
      "/mnt/containers/jellyfin/media:/media:ro"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.jellyfin.rule" = "PathPrefix(`/jellyfin`)";
      "traefik.http.services.jellyfin.loadbalancer.server.port" = "8096";
      "traefik.http.middlewares.jf-strip.stripprefix.prefixes" = "/jellyfin/";
      "traefik.http.middlewares.jf-redirect.redirectregex.regex" = "^(.*)/jellyfin$";
      "traefik.http.middlewares.jf-redirect.redirectregex.replacement" = "$1/jellyfin/";
      "traefik.http.routers.jellyfin.middlewares" = "jf-redirect,jf-strip";
    };
  };
}
