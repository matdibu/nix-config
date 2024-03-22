{ inputs
, modulesPath
, ...
}: {
  imports = [
    "${modulesPath}/profiles/minimal.nix"
    inputs.srvos.modules.nixos.server
    ./hardware
  ];

  system.stateVersion = "24.05";
}
