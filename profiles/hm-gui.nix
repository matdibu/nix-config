{
  imports = [ ./hm-cli.nix ];

  home-manager = {
    users.mateidibu = import ../home/mateidibu/gui;
  };

  modules = {
    audio.enable = true;
    sway.enable = true;
  };

  programs.dconf.enable = true;
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
}
