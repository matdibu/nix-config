{ inputs, ... }:
let
  cliHome = [
    inputs.home-manager.nixosModule
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit inputs;
        };
        users.mateidibu = import ../home/mateidibu;
      };
    }
    { programs.fuse.userAllowOther = true; }
  ];

  guiHome = cliHome ++ [
    {
      home-manager = {
        users.mateidibu = import ../home/mateidibu/gui;
      };
    }
    { modules.audio.enable = true; }
    {
      programs.dconf.enable = true;
      security = {
        polkit.enable = true;
        rtkit.enable = true;
      };
    }
  ];

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
    nix-iso-x86_64 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "nix-iso";
    };
    nix-sd-card-aarch64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "nix-sd-card";
      modules = [ { nixpkgs.buildPlatform = "x86_64-linux"; } ];
    };
    nix-ws = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "nix-ws";
      modules = guiHome;
    };
    nix-x570 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "nix-x570";
      modules = guiHome;
    };
    nix-vp4670 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "nix-vp4670";
      modules = guiHome;
    };
    nix-rockpro64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "nix-rockpro64";
      modules = cliHome;
    };
    nix-rockpro64-cross = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "nix-rockpro64";
      modules = cliHome ++ [ { nixpkgs.buildPlatform = "x86_64-linux"; } ];
    };
    nix-starbook = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "nix-starbook";
      modules = guiHome;
    };
  };
}
