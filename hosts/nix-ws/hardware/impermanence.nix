{ config, ... }: {
  environment.persistence.${config.impermanence.mountpoint} = {
    users."mateidibu" = {
      directories = [
        "git"
      ];
      files = [
        ".ssh/id_ed25519"
        ".ssh/id_ed25519.pub"
      ];
    };
  };
}
