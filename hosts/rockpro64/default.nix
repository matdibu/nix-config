{ inputs, ... }:
{
  imports = [
    ./hardware.nix
    inputs.self.nixosModules.profiles-lan-filesharing
  ];

  modules.system-type = "server";

  system.stateVersion = "24.11";
}
