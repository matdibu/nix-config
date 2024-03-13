{
  networking = {
    hostId = "63364f39";
  };

  systemd.network.networks."10-wan" = {
    matchConfig.Name = "enp0s1";
    networkConfig = {
      DHCP = "ipv4";
      # IPv6AcceptRA = true;
    };
    linkConfig.RequiredForOnline = "routable";
  };
}
