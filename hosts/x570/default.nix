{
  imports = [
    ./hardware
    ./roles/hypervisor
    # ./roles/nas
    ./roles/container-host
  ];

  modules = {
    sway.enable = true;
  };

  system.stateVersion = "24.05";
}
