{
  networking = {
    firewall.enable = true;
    useDHCP = false;
    networkmanager.enable = false;
    nftables.enable = true;
    # temporarily off while resolving route config
    enableIPv6 = false;
  };
  systemd.network.enable = true;
}
