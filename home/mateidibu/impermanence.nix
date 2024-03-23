{ osConfig, inputs, ... }: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];
  home.persistence."${osConfig.impermanence.mountpoint}/home" = {
    allowOther = true;
    files = [
      ".ssh/id_ed25519_sk_rk_yubi-backup_mateidibu"
    ];
  };
}
