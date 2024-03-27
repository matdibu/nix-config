{
  networking.hostId = "";

  systemd.network.networks."10-wan" = {
    matchConfig.Name = "";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
    };
    linkConfig.RequiredForOnline = "routable";
  };
}
