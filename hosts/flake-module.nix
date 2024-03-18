{inputs, ...}: let
  commonProfiles = with inputs.self.nixosModules;
    [
      profiles-docs
      profiles-misc
      profiles-nix-nixpkgs
      profiles-security
      profiles-openssh
      profiles-users
    ]
    ++ (with inputs.srvos.nixosModules; [
      common
    ]);

  commonHome = [
    inputs.home-manager.nixosModule
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs;};
        users.mateidibu = import ../home/mateidibu;
      };
    }
    {
      programs.fuse.userAllowOther = true;
    }
  ];

  guiHome = with inputs.self.nixosModules;
    [
      profiles-audio
      profiles-opengl
    ]
    ++ (with inputs.srvos.nixosModules; [desktop])
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

  nixosSystem = args: (inputs.nixpkgs.lib.nixosSystem ((builtins.removeAttrs args ["hostName"])
    // {
      specialArgs = {inherit inputs;} // args.specialArgs or {};
      modules =
        [
          ./${args.hostName}
          {networking = {inherit (args) hostName;};}
        ]
        ++ commonProfiles
        ++ (args.modules or []);
    }));
in {
  flake.nixosConfigurations = {
    nix-iso = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-iso";
      modules = with inputs.self.nixosModules; [
        profiles-misc
        profiles-nix-nixpkgs
        profiles-security
        profiles-openssh
      ];

    };
    nix-ws = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-ws";
      modules = commonProfiles ++ commonHome ++ guiHome;
    };
    nix-hv = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-hv";
      modules = commonProfiles;
    };
    nix-vp4670 = nixosSystem {
      system = "x86_64-linux";
      hostName = "nix-vp4670";
      modules = commonProfiles ++ commonHome ++ guiHome;
    };
  };
}
