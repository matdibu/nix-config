{
  modules = {
    nfs-share.enable = true;
    smb-share.enable = true;
  };

  services.nfs.server.exports = ''
    /mnt          0.0.0.0/0(rw,fsid=0,no_subtree_check)
    /mnt/torrents 0.0.0.0/0(ro,nohide,insecure,no_subtree_check,pnfs,all_squash)
  '';

  services.samba.shares = {
    "torrents" = {
      "path" = "/mnt/torrents";
      "writeable" = "no";
    };
  };
}
