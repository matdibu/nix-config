{
  networking.hostId = "9edbfeb8";

  # systemd.network.networks."10-wan" = {
  #   matchConfig.Name = "end0";
  #   networkConfig = {
  #     DHCP = "ipv4";
  #     IPv6AcceptRA = true;
  #   };
  #   linkConfig.RequiredForOnline = "routable";
  # };
}
