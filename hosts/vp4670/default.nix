{ pkgs, ... }:
{
  imports = [ ./hardware ];

  modules = {
    sway.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "24.05";
}
