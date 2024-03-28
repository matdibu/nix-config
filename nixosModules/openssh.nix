{ lib, config, ... }: {
  options = {
    modules.openssh.enable = lib.mkEnableOption "OpenSSH settings and authorized keys" // { default = true; };
  };
  config = lib.mkIf config.modules.openssh.enable {
    users.users = {
      "root" = {
        openssh.authorizedKeys.keys = with (import ../ssh-keys.nix); [
          yubi-main
          yubi-backup
          pixel8
        ];
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
