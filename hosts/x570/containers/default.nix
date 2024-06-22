{
  imports = [
    ./jellyfin.nix
    ./qbittorrent.nix
    ./traefik.nix
  ];

  modules.oci-containers.enable = true;
}
