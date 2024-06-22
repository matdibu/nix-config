{
  networking.firewall = {
    allowedTCPPorts = [
      9000
      9001
    ];
  };

  virtualisation.oci-containers.containers."traefik" = {
    image = "traefik@sha256:3212a585ed12db136baaa944f1c2adca228f4722afaac8daed984fda07487b65";
    ports = [
      "9000:9000/tcp"
      "9080:9001/tcp"
    ];
    volumes = [
        "/run/podman/podman.sock:/var/run/docker.sock:z"
    ];
    cmd = [
        "--log.level=info"
        "--accesslog=true"
        "--providers.docker"
        "--api.dashboard=true"
        "--api.insecure=true"
        "--entrypoints.http.address=:9000"
        "--entrypoints.http.asDefault=true"
    ];
    labels = {
        "traefik.enable"="true";
        "traefik.http.routers.mydashboard.rule"="Host(`traefik.mateidibu.dev`)";
        "traefik.http.routers.mydashboard.service"="api@internal";
    };
  };
}
