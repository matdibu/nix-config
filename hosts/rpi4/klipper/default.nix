{ lib, ... }:
let
  inherit (builtins) readFile toFile;
in
{
  networking.firewall.allowedTCPPorts = [
    80
    7125
    7130
  ];

  networking.firewall.enable = lib.mkForce false;

  nixpkgs.overlays = [
    (_final: prev: {
      klipper-firmware = prev.klipper-firmware.overrideAttrs (oldAttrs: {
        installPhase =
          oldAttrs.installPhase
          + ''
            cp out/klipper.uf2 $out/ || true
          '';
      });
    })
    # (_final: prev: {
    #   klipper-firmware = prev.klipper-firmware.overrideAttrs (oldAttrs: {
    #     nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
    #       pkgs.pkgsCross.aarch64-embedded.stdenv.cc
    #       pkgs.pkgsCross.arm-embedded.stdenv.cc
    #       pkgs.pkgsCross.avr.stdenv.cc
    #       pkgs.pkgsCross.raspberryPi.stdenv.cc
    #     ];
    #   });
    # })
    # (_final: prev: {
    #   klipper-firmware = prev.klipper-firmware.override {
    #     gcc-arm-embedded = pkgs.gcc-arm-embedded-11;
    #   };
    # })
  ];

  services = {
    klipper = {
      enable = true;
      logFile = "/var/lib/klipper/klipper.log";
      configFile = toFile "ender3-btt-skr-mini-e3-v3.cfg" (
        readFile ./config/include/btt-skr-mini-e3-v3.cfg
        + readFile ./config/include/ender3.cfg
        + readFile ./config/include/macros.cfg
        + readFile ./config/ender3-btt-skr-mini-e3-v3.cfg
        # + readFile ./config/adxl345-v2.0.cfg
      );
      firmwares = {
        "btt-skr-mini-e3-v3" = {
          enable = true;
          configFile = ./firmware/btt-skr-mini-e3-v3.cfg;
          enableKlipperFlash = true;
          serial = "/dev/serial/by-id/usb-Klipper_stm32g0b1xx_420013000250415339373620-if00";
        };
        "btt-adxl345-v2" = {
          enable = true;
          configFile = ./firmware/btt-adxl345-v2.cfg;
          enableKlipperFlash = true;
          serial = "/dev/serial/by-id/usb-Klipper_rp2040_454741505C0335AA-if00";
        };
      };
    };

    moonraker = {
      enable = true;
      user = "root";
      settings = {
        authorization = {
          cors_domains = [ "*.lan" ];
          trusted_clients = [
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
