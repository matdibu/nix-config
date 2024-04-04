{
  imports = [ ./hardware ];

  modules = {
    sway.enable = true;
  };

  services.upower.enable = true;

  system.stateVersion = "24.05";
}
