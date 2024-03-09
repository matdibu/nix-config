{inputs, ...}: {
  imports =
    [
      ./hardware-configuration
      ./networking.nix
    ]
    ++ (with inputs.self.nixosModules; [
      profiles-zfs
      profiles-audio
      profiles-opengl
    ]);

  system.stateVersion = "24.05";
}
