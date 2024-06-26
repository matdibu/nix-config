let
  version = "sha256:3212a585ed12db136baaa944f1c2adca228f4722afaac8daed984fda07487b65";
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
