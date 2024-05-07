{ inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModule
    ./better-defaults.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    users.mateidibu = import ../home/mateidibu;
  };

  programs.fuse.userAllowOther = true;
}
