{ lib, config, ... }:
{
  options = {
    modules.better-networking.enable = lib.mkEnableOption "modern networking";
  };

  config = lib.mkIf config.modules.better-networking.enable {
    networking = {
      firewall.enable = true;
      useDHCP = false;
      networkmanager.enable = false;
      nftables.enable = true;
    };
    systemd.network.enable = true;
  };
}
