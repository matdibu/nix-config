{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  environment.systemPackages = with pkgs; [
    gitMinimal
  ];
}
