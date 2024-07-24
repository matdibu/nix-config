{
  fileSystems."/mnt/junk" = {
    device = "vp4670.lan:/junk";
    fsType = "nfs4";
    options = [ "_netdev,noresvport" ];
  };
  fileSystems."/mnt/torrents" = {
    device = "vp4670.lan:/torrents";
    fsType = "nfs4";
    options = [ "_netdev,noresvport" ];
  };
}
