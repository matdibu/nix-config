{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";

  environment.systemPackages = with pkgs; [
    gitMinimal
  ];
}
