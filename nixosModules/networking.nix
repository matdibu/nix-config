{ lib, config, ... }: {
  options = {
    modules.networking-modern.enable = lib.mkEnableOption "Use modern networking" // { default = true; };
  };
  config = lib.mkIf config.modules.networking-modern.enable {
    networking = {
      firewall.enable = true;
      useDHCP = false;
      networkmanager.enable = false;
      nftables.enable = true;
    };
    systemd.network.enable = true;
  };
}
