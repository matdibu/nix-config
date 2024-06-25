{
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
    moonraker.enable = true;
    mainsail.enable = true;
  };
}
