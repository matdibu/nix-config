{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.profiles-server
    ./hardware
  ];

  system.stateVersion = "24.11";
}
