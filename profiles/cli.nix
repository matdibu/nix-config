{ inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModule
    ./server.nix
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
