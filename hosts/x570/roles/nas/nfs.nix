{
  services.nfs.server = {
    enable = true;
    exports = ''
      /mnt/torrents 192.168.1.0/24(rw,insecure,no_subtree_check,pnfs,all_squash)
    '';
    extraNfsdConfig = ''
      vers2=no
      vers3=no
      vers4=yes
      vers4.0=yes
      vers4.1=yes
      vers4.2=yes
    '';
  };
  networking.firewall.allowedTCPPorts = [ 2049 ];
}
