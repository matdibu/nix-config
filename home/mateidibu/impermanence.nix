{ osConfig, inputs, lib, ... }: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];
  config = lib.mkIf osConfig.impermanence.enable {
    home.persistence."${osConfig.impermanence.mountpoint}" = {
      allowOther = true;
      files = [
        # ".ssh/id_ed25519_sk_rk_yubi-backup_mateidibu"
      ];
    };
  };
}
