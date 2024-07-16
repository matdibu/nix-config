let
  version = "sha256:ab0ca2603e47e42f7d45e094b6f4cecc5d5b7b0ef6ca89170ce1a771ed1a0066";
in
{
  virtualisation.oci-containers.containers."whoami" = {
    image = "docker.io/traefik/whoami@${version}";
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.whoami.rule" = "PathPrefix(`/whoami`)";
    };
  };
}
