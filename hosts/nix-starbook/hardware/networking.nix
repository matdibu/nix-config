{
  networking.hostId = "c8041639";

  networking.wireless.iwd = {
    enable = true;
    settings = {
      Settings = {
        TransitionDisable = true;
        DsiabledTransitionModes = "personal,enterprise,open";
        AutoConnect = true;
      };
    };
  };

  systemd.network.networks."10-wan" = {
    matchConfig.Name = "wlan0";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
      IgnoreCarrierLoss = "3s";
    };
    linkConfig.RequiredForOnline = "routable";
  };
}
