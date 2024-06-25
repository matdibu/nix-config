{
  services = {
    klipper = {
      enable = true;
      configFile = ./klipper-creality-v4.2.7.cfg;
      firmwares = {
        "ender3" = {
            enable = true;
            configFile = ./firmware-creality-v4.2.7.cfg;
        };
      };
    };
    moonraker.enable = true;
    mainsail.enable = true;
  };
}
