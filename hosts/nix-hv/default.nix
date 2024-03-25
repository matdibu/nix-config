{
  imports = [
    ./hardware
    # ./roles/hypervisor
    # ./roles/nas
    # ./roles/container-host
  ];

  security.sudo.enable = false;

  system.stateVersion = "24.05";
}
