{ inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModule
    inputs.self.nixosModules.profiles-better-defaults
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
