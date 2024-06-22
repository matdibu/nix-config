{
  networking.hostId = "6c2854ca";

  systemd.network.networks."10-wan" = {
    matchConfig.Name = "enp5s0";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
      MulticastDNS = true;
    };
    linkConfig.RequiredForOnline = "routable";
  };
}
