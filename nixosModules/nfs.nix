{ lib, config, ... }:
{
  options = {
    modules.nfs-share.enable = lib.mkEnableOption "nfs network share";
  };

  config = lib.mkIf config.modules.nfs-share.enable {
    networking.firewall.allowedTCPPorts = [ 2049 ];

    services.nfs = {
      server = {
        enable = true;
        # # example:
        # exports = ''
        #   /mnt          192.168.1.0/24(rw,fsid=0,no_subtree_check)
        #   /mnt/torrents 192.168.1.0/24(ro,nohide,insecure,no_subtree_check,pnfs,all_squash)
        # '';
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
  };
}
