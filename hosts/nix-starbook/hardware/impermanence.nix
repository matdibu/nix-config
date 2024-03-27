{ config, ... }: {
  environment.persistence.${config.impermanence.mountpoint} = {
    users."mateidibu" = {
      directories = [
        "git"
      ];
    };
  };
}
