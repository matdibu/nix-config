{
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    extraConfig = ''
      IdentityFile ~/.ssh/id_ed25519_sk_rk_yubi-fast-backup_mateidibu
    '';
  };
}
