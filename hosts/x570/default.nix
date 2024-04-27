# { pkgs, ... }:
{
  imports = [
    ./hardware
    ./roles/hypervisor
    ./roles/nas
    ./roles/container-host
  ];

  # programs.steam = {
  #   enable = true;
  #   extraCompatPackages = with pkgs; [ proton-ge-bin ];
  # };

  system.stateVersion = "24.05";
}
