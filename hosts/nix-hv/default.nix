{
  inputs,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/minimal.nix"
    inputs.srvos.modules.nixos.server
    ./hardware-configuration
    ./security.nix
    ./networking.nix
    ./roles/hypervisor
    ./roles/nas
  ];

  system.stateVersion = "24.05";
}
