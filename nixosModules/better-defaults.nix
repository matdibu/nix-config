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
      vim.defaultEditor = true;
      nano.enable = false;
      git.enable = true;
      htop.enable = true;
    };

    # Packages that shoulds always be available.
    environment.systemPackages = with pkgs; [
      wget
      tree
      curl
      jq
      pciutils
      usbutils
      lm_sensors
    ];

    time.timeZone = "Europe/Bucharest";
    i18n.defaultLocale = "en_US.UTF-8";

    services.dbus.implementation = "broker";

    hardware.enableAllFirmware = true;

    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    boot.initrd.systemd.enable = true;

    boot.consoleLogLevel = 8;
  };
}
