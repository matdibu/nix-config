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
    #   klipper = prev.klipper.overrideAttrs (_oldAttrs: {
    #     version = "0.12.0-unstable-2024-07-18";
    #     src = prev.fetchFromGitHub {
    #       owner = "KevinOConnor";
    #       repo = "klipper";
    #       rev = "12cd1d9e81c32b26ccc319af1dfc3633438908f1";
    #       sha256 = "sha256-swjZc3Lu8rOwaYQby8QQvTzuNnxtTAaZx7TY/D8Z7Qg=";
    #     };
    #   });
    # })
    # (_final: prev: {
    #   moonraker = prev.moonraker.overrideAttrs (_oldAttrs: {
    #     version = "0.8.0-unstable-2024-07-5";
    #     src = prev.fetchFromGitHub {
    #       owner = "Arksine";
    #       repo = "moonraker";
    #       rev = "dc00d38b01915b9aea736999df9287b2846dd6bf";
    #       sha256 = "sha256-5woxDg88L3vYf9TUKiC4+1KAMcAQU0SRH8aRm1FGBDw=";
    #     };
    #   });
    # })
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
            "0.0.0.0/0"
            "192.168.1.0/24"
            "FE80::/10"
            "FC00::/7"
            "::1/128"
          ];
        };
      };
    };

    mainsail.enable = true;
  };
}
