{ config, ... }:
{
  home-manager.users."mateidibu" = {
    home.persistence."${config.modules.impermanence.mountpoint}/home/mateidibu" = {
      directories = [
        ".local/share/openmw"
        ".config/openmw"
      ];
    };
  };
}
