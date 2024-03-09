{inputs, ...}: {
  imports =
    [
      ./hardware-configuration
      ./networking.nix
    ]
    ++ (with inputs.self.nixosModules; [
      profiles-audio
      profiles-opengl
    ]);

  system.stateVersion = "24.05";
}
