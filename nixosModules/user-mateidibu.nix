{ lib, config, ... }:
{
  options = {
    modules.user-mateidibu.enable = lib.mkEnableOption "personal user";
  };

  config = lib.mkIf config.modules.user-mateidibu.enable {
    sops = {
      secrets = {
        "users/mateidibu/password" = {
          neededForUsers = true;
        };
      };
    };
    users.users.mateidibu = {
      isNormalUser = true;
      uid = 1000;
      hashedPasswordFile = config.sops.secrets."users/mateidibu/password".path;
      extraGroups = [
        "wheel"
        "video"
      ] ++ lib.optional config.virtualisation.libvirtd.enable "libvirtd";
      openssh.authorizedKeys.keys = lib.attrValues (import ../ssh-keys.nix);
    };
  };
}
