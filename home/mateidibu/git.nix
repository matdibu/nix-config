{
  home.sessionVariables = { GIT_SSH_COMMAND = "ssh -4"; };
  programs.git = {
    enable = true;
    userName = "Matei Dibu";
    ignores = [ "result" ];
    extraConfig = { push.autoSetupRemote = true; };
    includes = [
      {
        contents = {
          user.email = "contact@mateidibu.dev";
          user.signingkey = "F957752F1459A485552EEA729194B194C140DBED";
          # commit.gpgsign = true;
          # tag.gpgsign = true;
          extraConfig = {
            core = {
              sshCommand =
                "ssh -4 -i ~/.ssh/id_ed25519_sk_rk_yubi-backup_mateidibu";
            };
          };
        };
        condition = "gitdir:~/git/personal/";
      }
      {
        contents = {
          user.email = "contact@mateidibu.dev";
          extraConfig = {
            core = {
              sshCommand =
                "ssh -4 -i ~/.ssh/id_ed25519_sk_rk_yubi-backup_mateidibu";
            };
          };
        };
        condition = "gitdir:~/git/work/";
      }
    ];
  };
}
