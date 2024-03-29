{ osConfig, ... }: {
  imports = [
    ./direnv.nix
    ./packages.nix
    ./git.nix
    ./ssh.nix
    ./neovim
    ./impermanence.nix
  ];

  programs.bash.enable = true;

  home.stateVersion = osConfig.system.stateVersion;
}
