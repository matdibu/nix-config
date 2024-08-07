{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    modules.better-defaults.enable = lib.mkEnableOption "better defaults";
  };

  config = lib.mkIf config.modules.better-defaults.enable {
    programs = {
      vim = {
        enable = true;
        defaultEditor = true;
      };
    };

    # Packages that shoulds always be available.
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        wget
        tree
        curl
        jq
        pciutils
        usbutils
        lm_sensors
        htop
        git
        ;
    };

    time.timeZone = "Europe/Bucharest";
    i18n.defaultLocale = "en_US.UTF-8";

    services.dbus.implementation = "broker";

    hardware.enableAllFirmware = true;

    boot = {
      kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      initrd.systemd.enable = true;
      loader.systemd-boot = {
        configurationLimit = 5;
        consoleMode = "max";
        memtest86.enable = config.nixpkgs.hostPlatform == "x86_64-linux";
      };
    };
  };
}
