{ pkgs, ... }: {
  networking.hostId = "c8041639";

  environment.systemPackages = with pkgs; [ iwd wpa_supplicant ];

  systemd.network.networks."10-wan" = {
    matchConfig.Name = "wlp45s0";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
      IgnoreCarrierLoss = "3s";
    };
    linkConfig.RequiredForOnline = "routable";
  };
}
