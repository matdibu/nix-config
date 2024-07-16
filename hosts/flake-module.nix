{ inputs, ... }:
let
  # wrapper over 'nixosSystem', with default configs and imports
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
        ../nixosModules
        ./${args.hostName}
      ];
    };
in
{
  flake.nixosConfigurations = {
    iso-x86_64 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "iso";
    };
    iso-aarch64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "iso";
    };
    # sd-card-aarch64 = mkNixosSystem {
    #   system = "aarch64-linux";
    #   hostName = "sd-card";
    # };
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
