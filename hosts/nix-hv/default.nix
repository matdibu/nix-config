{ inputs
, modulesPath
, ...
}: {
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/minimal.nix"
    inputs.srvos.modules.nixos.server
    ./hardware
    ./security.nix
    ./roles/hypervisor
    ./roles/nas
    ./roles/container-host
  ];

  system.stateVersion = "24.05";
}
