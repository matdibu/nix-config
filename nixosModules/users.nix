{ lib, config, ... }: {
  options = {
    modules.user-mateidibu.enable = lib.mkEnableOption "personal user" // {
      default = true;
    };
  };
  config = lib.mkIf config.modules.user-mateidibu.enable {
    users.users.mateidibu = {
      isNormalUser = true;
      uid = 1000;
      hashedPassword =
        "$6$BuNLpB8FLnFemGV5$cm0ZIHhA1VMvxr8oYvQyyLkrLSnWiFXIYztvmkTVprO0BLjPzEhi1S5rp0QGvjHbrHJ4UiFh2JcfFAsNDcnct.";
      extraGroups = [ "wheel" "video" ]
        ++ lib.optional config.virtualisation.libvirtd.enable "libvirtd";
      openssh.authorizedKeys.keys = with (import ../ssh-keys.nix); [
        yubi-main
        yubi-backup
        pixel8
      ];
    };
  };
}
