let
  version = "sha256:b6966c4c623886228f59f9153b5b882aef72cc6fd3f3076e6e7f1b5efd248787";
in
{
  networking.firewall = {
    allowedTCPPorts = [
      8080
      80
      443
    ];
  };

  virtualisation.oci-containers.containers."traefik" = {
    image = "docker.io/library/traefik@${version}";
    ports = [
      "8080:8080/tcp"
      "80:80/tcp"
      "443:443/tcp"
    ];
    volumes = [ "/run/podman/podman.sock:/var/run/docker.sock:z" ];
    cmd = [
      "--providers.docker"
      "--providers.docker.exposedByDefault=false"
      "--api.dashboard"
      "--api.insecure"
    ];
  };
}
