let
  version = "sha256:7000846753fcc36eb2a1a3a21fe897da09c71e1d3b5381f912ea6e6e1c8871b6";
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
