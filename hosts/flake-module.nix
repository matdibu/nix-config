{inputs, ...}: let
  commonProfiles = with inputs.self.nixosModules; [
    profiles-docs
    profiles-misc
    profiles-nix-nixpkgs
    profiles-security
    profiles-openssh
    profiles-users
  ];

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

  nixosSystemWithDefaults = args: (inputs.nixpkgs.lib.nixosSystem ((builtins.removeAttrs args ["hostName"])
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
    nix-ws = nixosSystemWithDefaults {
      system = "x86_64-linux";
      hostName = "nix-ws";
      modules = commonHome ++ guiHome;
    };
  };
}
