{ self, inputs, ... }:
let
  inherit (self.nixosModules)
    profiles-installer
    # profiles-hm-cli
    profiles-hm-gui
    profiles-server
    ;

  # wrapper over 'nixosSystem', with default configs and imports
  mkNixosSystem =
    args:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      inherit (args) system;
      modules = [
        ./${args.hostName}
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
      ] ++ [ ../nixosModules ] ++ (args.modules or [ ]);
    };
in
{
  flake.nixosConfigurations = {
    iso-x86_64 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "iso";
      modules = [ profiles-installer ];
    };
    iso-aarch64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "iso";
      modules = [ profiles-installer ];
    };
    # sd-card-aarch64 = mkNixosSystem {
    #   system = "aarch64-linux";
    #   hostName = "sd-card";
    #   modules = [ profiles-installer ];
    # };
    x570 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "x570";
      modules = [ profiles-hm-gui ];
    };
    vp4670 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "vp4670";
      modules = [ profiles-hm-gui ];
    };
    rockpro64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "rockpro64";
      modules = [ profiles-server ];
    };
    rpi4 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "rpi4";
      modules = [ profiles-server ];
    };
  };
}
