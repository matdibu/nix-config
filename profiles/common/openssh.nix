let
  yubi-main = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMW4GCCqGSeikOdpTizkcWcALL7QTaXRN9yLtXKip/bUAAAADXNzaDp5dWJpLW1haW4= ssh:yubi-main";
  yubi-backup = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIExpu8Q76Btg0+3fVX0Upqvg/rUzmuijhzRoHk4g/KK3AAAAD3NzaDp5dWJpLWJhY2t1cA== ssh:yubi-backup";
  pixel8 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILIuz4s1PzR1dXg/zVquHWXHnCaBJZbmWZrEAxoW3r5w pixel8";
in {
  users.users = {
    "root" = {
      openssh.authorizedKeys.keys = [
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
}
