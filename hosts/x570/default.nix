{
  imports = [
    ./hardware
    # ./roles/hypervisor
    ./roles/nas
    ./roles/container-host
  ];

  programs.steam.enable = true;

  system.stateVersion = "24.05";
}
