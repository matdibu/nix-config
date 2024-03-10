{
  pkgs,
  lib,
  ...
}: {
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
  ];

  time.timeZone = lib.mkDefault "Europe/Bucharest";
  i18n.defaultLocale = "en_US.UTF-8";

  services.dbus.implementation = "broker";

  security.sudo = {
    # Only allow members of the wheel group to execute sudo by setting the executable’s permissions accordingly.
    # This prevents users that are not members of wheel from exploiting vulnerabilities in sudo such as CVE-2021-3156.
    execWheelOnly = true;
    extraConfig = ''
      Defaults lecture = never
    '';
  };
}
