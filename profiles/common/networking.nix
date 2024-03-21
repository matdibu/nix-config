{
  networking = {
    firewall.enable = true;
    useDHCP = false;
    networkmanager.enable = false;
    nftables.enable = true;
  };
  systemd.network.enable = true;
}
