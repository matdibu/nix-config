{
  imports = [
    ./hardware
    ./security.nix
    ./roles/hypervisor
    ./roles/nas
    ./roles/container-host
  ];

  system.stateVersion = "24.05";
}
