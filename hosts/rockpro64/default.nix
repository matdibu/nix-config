{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.profiles-better-defaults
    ./hardware
  ];

  system.stateVersion = "24.11";
}
