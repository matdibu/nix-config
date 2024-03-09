{
  programs.git = {
    enable = true;
    userName = "Matei Dibu";
    userEmail = "contact@mateidibu.dev";
    ignores = ["result"];
    extraConfig = {
      push.autoSetupRemote = true;
    };
    includes = [
      {
        contents = {
          user.signingkey = "F957752F1459A485552EEA729194B194C140DBED";
          # commit.gpgsign = true;
          # tag.gpgsign = true;
          extraConfig = {
            core = {
              sshCommand = "ssh -i ~/.ssh/id_ed25519";
            };
          };
        };
        condition = "hasconfig:remote.*.url:git@codeberg.org:*";
      }
    ];
  };
}
