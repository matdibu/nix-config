{ config, ... }: {
  environment.persistence.${config.modules.impermanence.mountpoint} = {
    users."mateidibu" = { directories = [ "git" ]; };
  };
}
