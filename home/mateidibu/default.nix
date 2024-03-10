{
  imports = [
    ./direnv.nix
    ./packages.nix
    ./git.nix
    ./ssh.nix
    ./editors.nix
  ];

  programs.bash.enable = true;

  home.stateVersion = "24.05";
}
