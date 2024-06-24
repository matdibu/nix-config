{
  imports = [
    ./jellyfin.nix
    ./qbittorrent.nix
    ./traefik.nix
    ./whoami.nix
  ];

  modules.oci-containers.enable = true;

  modules.oci-containers.storage-path = "/mnt/containers/";
  # modules.impermanence.extraVolumes = [ "containers" ];
}
