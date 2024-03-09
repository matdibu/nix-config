{
  imports = [
    ./direnv.nix
    ./packages.nix
    ./fonts.nix
    ./git.nix
    ./ssh.nix
    ./editors.nix
  ];

  home.stateVersion = "24.05";
}
