{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    modules.better-defaults.enable = lib.mkEnableOption "better defaults" // {
      default = true;
    };
  };
  config = lib.mkIf config.modules.better-defaults.enable {
    programs.vim.defaultEditor = true;
    programs.nano.enable = false;

    # Packages that shoulds always be available.
    environment.systemPackages = with pkgs; [
      wget
      gitMinimal
      tree
      curl
      jq
      htop
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
  };
}
