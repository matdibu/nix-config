{ inputs, ... }:
let
  cliHome = [
    inputs.home-manager.nixosModule
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
        users.mateidibu = import ../home/mateidibu;
      };
    }
    {
      programs.fuse.userAllowOther = true;
    }
  ];

  guiHome = cliHome ++ [
    {
      home-manager = {
        users.mateidibu = import ../home/mateidibu/gui;
      };
    }
    {
      programs.dconf.enable = true;
      security = {
        polkit.enable = true;
        rtkit.enable = true;
      };
    }
  ];

  nixosSystem = args: (inputs.nixpkgs.lib.nixosSystem ((builtins.removeAttrs args [ "hostName" ])
    // {
    specialArgs = { inherit inputs; } // args.specialArgs or { };
    modules =
      [
        ./${args.hostName}
        { networking = { inherit (args) hostName; }; }
        { nixpkgs.hostPlatform = { inherit (args) system; }; }
      ]
      ++ [ ../nixosModules ]
      ++ (args.modules or [ ]);
  }));
in
{
  flake.nixosConfigurations = {
    nix-iso = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-iso";
    };
    nix-ws = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-ws";
      modules = guiHome;
    };
    nix-x570 = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-x570";
      modules = guiHome;
    };
    nix-vp4670 = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-vp4670";
      modules = guiHome;
    };
    nix-rockpro64 = nixosSystem {
      system = "aarch64-linux";
      hostName = "nix-rockpro64";
      modules = cliHome;
    };
    nix-starbook = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-starbook";
      modules = guiHome;
    };
  };
}
