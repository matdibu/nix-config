{ lib, ... }:
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
    image = "lscr.io/linuxserver/qbittorrent:latest";
    environment = {
      PGID = "0";
      PUID = "0";
      TORRENTING_PORT = "6881";
      TZ = "Europe/Bucharest";
      WEBUI_PORT = "8080";
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
    log-driver = "journald";
    extraOptions = [ "--network=host" ];
  };

  systemd.services."podman-qbittorrent" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
    };
    partOf = [ "podman-compose-nix-containers-root.target" ];
    wantedBy = [ "podman-compose-nix-containers-root.target" ];
  };
}
