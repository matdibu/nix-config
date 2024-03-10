{
  inputs,
  pkgs,
  ...
}: {
  imports =
    [
      ./hardware-configuration
      ./networking.nix
    ]
    ++ (with inputs.self.nixosModules; [
      profiles-audio
      profiles-opengl
      profiles-sway
    ]);

  programs.dconf.enable = true;

  services.dbus = {
    enable = true;
    packages = [pkgs.dconf];
  };

  system.stateVersion = "24.05";
}
