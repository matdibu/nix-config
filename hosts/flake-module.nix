{ inputs, ... }:
let
  # wrapper over 'nixosSystem', with default configs and imports
  mkNixosSystem =
    args:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        allHosts = args.allHosts or null;
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
    iso-allHosts-x86_64 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "iso";
      allHosts = true;
    };
    iso-allHosts-aarch64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "iso";
      allHosts = true;
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
