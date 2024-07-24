{ lib, ... }:
{
  modules = {
    nfs-share.enable = true;
    smb-share.enable = true;
  };

  networking.firewall.enable = lib.mkForce false;

  fileSystems."/export/torrents" = {
    device = "/mnt/torrents";
    options = [ "bind" ];
  };
  fileSystems."/export/junk" = {
    device = "/mnt/junk";
    options = [ "bind" ];
  };

  services.nfs.server.exports = ''
    /export          *(rw,fsid=0,no_subtree_check)
    /export/torrents *(ro,nohide,insecure,no_subtree_check,pnfs,all_squash)
    /export/junk     *(rw,nohide,insecure,no_subtree_check,pnfs,all_squash)
  '';

  services.samba.shares = {
    "torrents" = {
      "path" = "/mnt/torrents";
      "writeable" = "no";
    };
    "junk" = {
      "path" = "/mnt/junk";
      "writeable" = "yes";
    };
  };
}
