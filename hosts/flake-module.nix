{ inputs, ... }:
let

  betterDefaults = [
    {
      modules = {
        better-defaults.enable = true;
        better-networking.enable = true;
        better-nix.enable = true;
        remove-docs.enable = true;
        openssh.enable = true;
        smartd.enable = true;
        user-mateidibu.enable = true;
      };
    }
  ];

  cliHome = betterDefaults ++ [
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
    iso-x86_64 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "iso";
    };
    iso-aarch64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "iso";
      modules = [ { nixpkgs.buildPlatform = "x86_64-linux"; } ];
    };
    sd-card-aarch64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "sd-card";
      modules = [ { nixpkgs.buildPlatform = "x86_64-linux"; } ];
    };
    ws = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "ws";
      modules = guiHome;
    };
    x570 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "x570";
      modules = guiHome;
    };
    vp4670 = mkNixosSystem {
      system = "x86_64-linux";
      hostName = "vp4670";
      modules = guiHome;
    };
    rockpro64 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "rockpro64";
      modules = cliHome;
    };
    rockpro64-cross = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "rockpro64";
      modules = cliHome ++ [ { nixpkgs.buildPlatform = "x86_64-linux"; } ];
    };
    rpi4 = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "rpi4";
      modules = cliHome;
    };
    rpi4-cross = mkNixosSystem {
      system = "aarch64-linux";
      hostName = "rpi4";
      modules = cliHome ++ [ { nixpkgs.buildPlatform = "x86_64-linux"; } ];
    };
  };
}
