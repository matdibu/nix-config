{
  networking.hostId = "65dd03a2";

  systemd.network.networks."10-wan" = {
    matchConfig.Name = "end0";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
    };
    linkConfig.RequiredForOnline = "routable";
  };
}
