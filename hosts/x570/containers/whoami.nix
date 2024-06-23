{
  virtualisation.oci-containers.containers."whoami" = {
    image = "traefik/whoami";
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.whoami.rule" = "PathPrefix(`/whoami`)";
    };
  };
}
