{ inputs, ... }:
let
  commonModules =
    with inputs.self.nixosModules; [
      profiles-common
      modules-impermanence
    ];

  impermanenceModules = (with inputs.self.nixosModules; [
    profiles-zfs
  ]) ++ [
    { impermanence.enable = true; }
  ];

  commonServer = with inputs.self.nixosModules; [
    profiles-server
    profiles-hardened-zfs
  ];

  commonHome = [
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

  guiHome = commonHome ++ (with inputs.self.nixosModules;[
    profiles-audio
  ])
    ++ [
    {
      home-manager = {
        users.mateidibu = import ../home/mateidibu/gui;
      };
    }
    {
      programs.dconf.enable = true;
      security.polkit.enable = true;
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
      ++ commonModules
      ++ (args.modules or [ ]);
  }));
in
{
  flake.nixosConfigurations = {
    nix-iso = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        inputs.self.nixosModules.profiles-common
        ./nix-iso
      ];
    };
    nix-ws = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-ws";
      modules = impermanenceModules ++ guiHome;
    };
    nix-x570 = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-x570";
      modules = impermanenceModules ++ guiHome;
    };
    nix-vp4670 = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-vp4670";
      modules = impermanenceModules ++ guiHome;
    };
    nix-rockpro64 = nixosSystem {
      system = "aarch64-linux";
      hostName = "nix-rockpro64";
      modules = impermanenceModules ++ commonServer ++ commonHome;
    };
    nix-starbook = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-starbook";
      modules = guiHome;
    };
  };
}
