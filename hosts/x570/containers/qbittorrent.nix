let
  version = "sha256:c5d8ae78460772deaf9b3bd91055f4ad19ab85cc6ebe1392369475d10cfffa52";
in
{
  fileSystems."/mnt/containers/qbittorrent/downloads" = {
    device = "/mnt/torrents";
    options = [ "bind" ];
  };

  virtualisation.oci-containers.containers."qbittorrent" = {
    image = "ghcr.io/qbittorrent/docker-qbittorrent-nox@${version}";
    environment = {
      QBT_EULA = "accept";
      QBT_LEGAL_NOTICE = "confirm";
      QBT_WEBUI_PORT = "8080";
      PGID = "100";
    };
    volumes = [
      "/mnt/containers/qbittorrent/config:/config:rw"
      "/mnt/containers/qbittorrent/downloads:/downloads:rw"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.qbittorrent.rule" = "PathPrefix(`/qbittorrent`)";
      "traefik.http.services.qbittorrent.loadbalancer.server.port" = "8080";
      "traefik.http.middlewares.qb-strip.stripprefix.prefixes" = "/qbittorrent/";
      "traefik.http.middlewares.qb-redirect.redirectregex.regex" = "^(.*)/qbittorrent$";
      "traefik.http.middlewares.qb-redirect.redirectregex.replacement" = "$1/qbittorrent/";
      "traefik.http.routers.qbittorrent.middlewares" = "qb-redirect,qb-strip";
    };
  };
}
