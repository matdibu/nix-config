{
  imports = [
    ./zfs.nix
    ./containers/qbittorrent
    ./containers/jellyfin
  ];

  systemd.targets."podman-compose-nix-containers-root".unitConfig = {
    After = [ "network-online.target" "systemd-networkd.service" ];
    Requires = [ "network-online.target" "systemd-networkd.service" ];
  };
}
