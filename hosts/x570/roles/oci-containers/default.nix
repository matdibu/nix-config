{
  imports = [
    ./jellyfin.nix
    ./qbittorrent.nix
  ];

  modules.oci-containers.enable = true;
}
