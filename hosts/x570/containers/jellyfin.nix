let
  version = "sha256:49572434ce4cf3f7b5f0d6ae775333260c77281dbe8da47cb6d96f03e81e8f1b";
in
{
  fileSystems."/mnt/containers/jellyfin/media" = {
    device = "/mnt/torrents";
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
