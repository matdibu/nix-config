{ inputs, ... }:
{
  imports = [
    ./hardware
    inputs.self.nixosModules.profiles-lan-filesharing
  ];

  modules.system-type.stype = "server";

  system.stateVersion = "24.11";
}
