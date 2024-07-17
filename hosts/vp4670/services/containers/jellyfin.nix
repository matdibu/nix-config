let
  version = "sha256:dc4467f8e4ea66e0aa8cfd0e50a31934df3218a4048c18dc86f835f496061f44";
in
{
  fileSystems."/mnt/containers/jellyfin/media" = {
    device = "/mnt/torrents";
    options = [ "bind" ];
  };

  systemd.tmpfiles.rules = [
    "d /mnt/containers/jellyfin/cache 0700 root root"
    "d /mnt/containers/jellyfin/config 0700 root root"
  ];

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
