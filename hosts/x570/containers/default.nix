{
  imports = [
    ./jellyfin.nix
    ./qbittorrent.nix
    ./traefik.nix
    ./whoami.nix
  ];

  modules.oci-containers.enable = true;
}
