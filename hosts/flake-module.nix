{ inputs, ... }:
let
  mkNixosSystem =
    args:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      inherit (args) system;
      modules = [
        {
          networking = {
            inherit (args) hostName;
          };
        }
        {
          nixpkgs.hostPlatform = {
            inherit (args) system;
          };
        }
        ./${args.hostName}
        ../nixosModules
      ];
    };
in
{
  flake.nixosConfigurations = {
    iso-offlineInstallers-x86_64 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "iso";
    };
    iso-offlineInstallers-aarch64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "iso";
    };
    x570 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "x570";
    };
    vp4670 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "vp4670";
    };
    rock64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "rock64";
    };
    rockpro64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "rockpro64";
    };
    rpi4 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "rpi4";
    };
  };
}
