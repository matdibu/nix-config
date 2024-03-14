{
  imports = [
    ./auto-generated.nix
  ];

  networking.firewall.allowedTCPPorts = [8096];

  systemd.targets."podman-jellyfin".unitConfig = {
    After = ["network-online.target" "systemd-networkd.service"];
    Requires = ["network-online.target" "systemd-networkd.service"];
  };

  fileSystems."/container-storage/jellyfin/media" = {
    device = "/torrents";
    options = ["bind"];
  };
}
