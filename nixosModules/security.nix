{ lib, config, ... }:
{
  options = {
    modules.security.enable = lib.mkEnableOption "Security Hardening";
  };

  config = lib.mkIf config.modules.security.enable {
    security.sudo = {
      # Only allow members of the wheel group to execute sudo by setting the executable’s permissions accordingly.
      # This prevents users that are not members of wheel from exploiting vulnerabilities in sudo such as CVE-2021-3156.
      execWheelOnly = true;
      extraConfig = ''
        Defaults lecture = never
      '';
    };
  };
}
