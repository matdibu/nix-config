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

  programs.dconf.enable = true;

  system.stateVersion = "24.05";
}
