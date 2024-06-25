{
  networking.firewall.allowedTCPPorts = [ 80 ];

  services = {
    klipper = {
      enable = true;
      configFile = ./klipper.cfg;
      firmwares = {
        "ender3" = {
          enable = true;
          configFile = ./firmware.cfg;
        };
      };
    };
    moonraker = {
      enable = true;
      user = "root";
    };
    mainsail.enable = true;
  };
}
