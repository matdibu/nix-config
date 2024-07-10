{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
    ./apps.nix
  ];

  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = true;
        deadnix.enable = true;
        statix.enable = true;
        stylua.enable = true;
      };
    };
  };
}
