{
  networking.firewall = {
    allowedTCPPorts = [
      8080 # Web UI
      6881 # connection
    ];
    allowedUDPPorts = [
      6881 # connection
    ];
  };

  fileSystems."/mnt/containers/qbittorrent/downloads" = {
    device = "/mnt/torrents";
    options = [ "bind" ];
  };

  virtualisation.oci-containers.containers."qbittorrent" = {
    image = "ghcr.io/qbittorrent/docker-qbittorrent-nox@sha256:ed8bbbbf9be0fbb69b9b6e063ed7d1260af86222c99f7907d6f04a764ced5ff5";
    environment = {
      PGID = "0";
      PUID = "0";
      # TORRENTING_PORT = "6881";
      QBT_EULA = "accept";
      QBT_LEGAL_NOTICE = "confirm";
      TZ = "Europe/Bucharest";
      QBT_WEBUI_PORT = "8080";
    };
    volumes = [
      "/mnt/containers/qbittorrent/config:/config:rw"
      "/mnt/containers/qbittorrent/downloads:/downloads:rw"
    ];
    ports = [
      "8080:8080/tcp"
      "6881:6881/tcp"
      "6881:6881/udp"
    ];
    extraOptions = [ "--network=host" ];
  };
}
