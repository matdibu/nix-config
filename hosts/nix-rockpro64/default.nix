{
  inputs,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/profiles/minimal.nix"
    inputs.srvos.modules.nixos.server
    ./hardware-configuration
    ./networking.nix
  ];

  system.stateVersion = "24.05";
}
