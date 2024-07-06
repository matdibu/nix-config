{ lib, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 80 ];

  networking.firewall.enable = lib.mkForce false;

  nixpkgs.overlays = [
    (_final: prev: {
      klipper-firmware = prev.klipper-firmware.override { gcc-arm-embedded = pkgs.gcc-arm-embedded-11; };
    })
  ];

  services = {
    klipper = {
      enable = true;
      mutableConfig = true;
      mutableConfigFolder = "/tmp/klipper";
      configFile = ./klipper-config/ender3-btt-skr-mini-e3-v3.cfg;
      firmwares = {
        "btt-skr-mini-e3-v3" = {
          enable = true;
          configFile = ./firmware/btt-skr-mini-e3-v3.cfg;
          serial = "/dev/serial/by-id/usb-Klipper_stm32g0b1xx_420013000250415339373620-if00";
        };
      };
    };

    moonraker = {
      enable = true;
      user = "root";
      settings = {
        authorization = {
          cors_domains = [
            "*.local"
            "*.lan"
            "*://app.fluidd.xyz"
            "*://my.mainsail.xyz"
          ];
          trusted_clients = [
            "10.0.0.0/8"
            "127.0.0.0/8"
            "169.254.0.0/16"
            "172.16.0.0/12"
            "192.168.1.0/24"
            "FE80::/10"
            "::1/128"
          ];
        };
      };
    };
    mainsail.enable = true;
  };
}
