{ pkgs, ... }: {
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

  security.sudo = {
    # Only allow members of the wheel group to execute sudo by setting the executable’s permissions accordingly.
    # This prevents users that are not members of wheel from exploiting vulnerabilities in sudo such as CVE-2021-3156.
    execWheelOnly = true;
    extraConfig = ''
      Defaults lecture = never
    '';
  };
}
