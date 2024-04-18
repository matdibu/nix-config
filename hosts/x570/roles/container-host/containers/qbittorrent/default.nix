{
  imports = [ ./auto-generated.nix ];

  networking.firewall = {
    allowedTCPPorts = [
      8080 # Web UI
      6881 # connection
    ];
    allowedUDPPorts = [
      6881 # connection
    ];
  };

  # systemd.targets."podman-qbittorrent".unitConfig = {
  #   After = [ "network-online.target" "systemd-networkd.service" ];
  #   Requires = [ "network-online.target" "systemd-networkd.service" ];
  # };

  fileSystems."/mnt/containers/qbittorrent/downloads" = {
    device = "/mnt/torrents";
    options = [ "bind" ];
  };
}
