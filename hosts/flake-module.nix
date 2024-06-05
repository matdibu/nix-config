{ self, inputs, ... }:
let
  inherit (self.nixosModules)
    profiles-installer
    profiles-gui
    profiles-cli
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
      ] ++ [ ../nixosModules ] ++ [ inputs.lix-module.nixosModules.default ] ++ (args.modules or [ ]);
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
      modules = [ profiles-installer ] ++ [ { nixpkgs.buildPlatform = "x86_64-linux"; } ];
    };
    sd-card-aarch64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "sd-card";
      modules = [ profiles-installer ] ++ [ { nixpkgs.buildPlatform = "x86_64-linux"; } ];
    };
    #ws = mkNixosSystem {
    #  system = "x86_64-linux";
    #  hostName = "ws";
    #  modules = [ profiles-gui ];
    #};
    x570 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "x570";
      modules = [ profiles-cli ];
    };
    vp4670 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "vp4670";
      modules = [ profiles-gui ];
    };
    rockpro64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "rockpro64";
      modules = [ profiles-server ];
    };
    rockpro64-cross = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "rockpro64";
      modules = [ profiles-server ] ++ [ { nixpkgs.buildPlatform = "x86_64-linux"; } ];
    };
    #rpi4 = mkNixosSystem {
    #  system = "aarch64-linux";
    #  hostName = "rpi4";
    #  modules = [ profiles-cli ];
    #};
    #rpi4-cross = mkNixosSystem {
    #  system = "aarch64-linux";
    #  hostName = "rpi4";
    #  modules = [ profiles-cli ] ++ [ { nixpkgs.buildPlatform = "x86_64-linux"; } ];
    #};
  };
}
