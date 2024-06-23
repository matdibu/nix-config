{
  services.nfs = {
    server = {
      enable = true;
      exports = ''
        /mnt          192.168.1.0/24(rw,fsid=0,no_subtree_check)
        /mnt/torrents 192.168.1.0/24(rw,nohide,insecure,no_subtree_check,pnfs,all_squash)
      '';
    };
    settings = {
      nfsd = {
        "vers2" = false;
        "vers3" = false;
        "vers4" = true;
        "vers4.0" = false;
        "vers4.1" = false;
        "vers4.2" = true;
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 2049 ];
}
