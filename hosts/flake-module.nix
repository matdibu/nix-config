{ inputs, ... }:
let
  # wrapper over 'nixosSystem', with default configs and imports
  mkNixosSystem =
    args:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        offlineInstallers = args.offlineInstallers or null;
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
      offlineInstallers = true;
    };
    iso-offlineInstallers-aarch64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "iso";
      offlineInstallers = true;
    };
    x570 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "x570";
    };
    vp4670 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "vp4670";
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
