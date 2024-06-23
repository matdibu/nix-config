{
  networking.firewall = {
    allowedTCPPorts = [
      8080
      80
      443
    ];
  };

  virtualisation.oci-containers.containers."traefik" = {
    image = "traefik@sha256:3212a585ed12db136baaa944f1c2adca228f4722afaac8daed984fda07487b65";
    ports = [
      "8080:8080/tcp"
      "80:80/tcp"
      "443:443/tcp"
    ];
    volumes = [ "/run/podman/podman.sock:/var/run/docker.sock:z" ];
    cmd = [
      "--providers.docker"
      "--api.dashboard=true"
      "--api.insecure=true"
    ];
  };
}
