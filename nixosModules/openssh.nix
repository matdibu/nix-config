{ lib, config, ... }:
{
  options = {
    modules.openssh.enable = lib.mkEnableOption "OpenSSH settings and authorized keys";
  };

  config = lib.mkIf config.modules.openssh.enable {
    users.users = {
      "root" = {
        openssh.authorizedKeys.keys = lib.attrValues (import ../ssh-keys.nix);
      };
    };
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        KexAlgorithms = [
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
          "diffie-hellman-group16-sha512"
          "diffie-hellman-group18-sha512"
          "sntrup761x25519-sha512@openssh.com"
        ];
      };
    };
  };
}
