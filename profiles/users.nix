{
  lib,
  config,
  ...
}: let
  yubi-main = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMW4GCCqGSeikOdpTizkcWcALL7QTaXRN9yLtXKip/bUAAAADXNzaDp5dWJpLW1haW4= ssh:yubi-main";
  yubi-backup = "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIExpu8Q76Btg0+3fVX0Upqvg/rUzmuijhzRoHk4g/KK3AAAAD3NzaDp5dWJpLWJhY2t1cA== ssh:yubi-backup";
  pixel8 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILIuz4s1PzR1dXg/zVquHWXHnCaBJZbmWZrEAxoW3r5w pixel8";
in {
  users.users.mateidibu = {
    isNormalUser = true;
    uid = 1000;
    hashedPassword = "$6$BuNLpB8FLnFemGV5$cm0ZIHhA1VMvxr8oYvQyyLkrLSnWiFXIYztvmkTVprO0BLjPzEhi1S5rp0QGvjHbrHJ4UiFh2JcfFAsNDcnct.";
    extraGroups =
      ["wheel"]
      ++ lib.optional config.virtualisation.libvirtd.enable "libvirtd";
    openssh.authorizedKeys.keys = [
      yubi-main
      yubi-backup
      pixel8
    ];
  };
}
