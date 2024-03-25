{
  imports = [
    ./auto-generated.nix
  ];

  networking.firewall = {
    allowedTCPPorts = [ 8080 6881 ];
    allowedUDPPorts = [ 6881 ];
  };

  systemd.targets."podman-qbittorrent".unitConfig = {
    After = [ "network-online.target" "systemd-networkd.service" ];
    Requires = [ "network-online.target" "systemd-networkd.service" ];
  };

  fileSystems."/container-storage/qbittorrent/downloads" = {
    device = "/torrents";
    options = [ "bind" ];
  };
}
