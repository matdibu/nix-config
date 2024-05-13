{
  osConfig,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];
  config = lib.mkIf osConfig.modules.impermanence.enable {
    home.persistence."${osConfig.modules.impermanence.mountpoint}/home/mateidibu" = {
      allowOther = true;
      files = [
        ".ssh/id_ed25519_sk_rk_yubi-backup_mateidibu"
        ".ssh/id_ed25519_sk_rk_yubi-fast-backup_mateidibu"
      ];
      directories = [
        #(lib.optional osConfig.programs.steam.enable ".local/share/Steam")
        ".local/share/Steam"
      ];
    };
  };
}
