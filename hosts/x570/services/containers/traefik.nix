let
  version = "sha256:e8a7348f5f65e91ea26b0969b8b0febb94d8e103e2c16e7ba8f56a596271255a";
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
