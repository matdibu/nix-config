{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModule ];
  options = {
    modules.system-type = {
      stype = lib.mkOption {
        type = lib.types.nullOr (
          lib.types.enum [
            "installer"
            "server"
            "headless-desktop"
            "graphical-desktop"
          ]
        );
        default = null;
      };
    };
  };

  config =
    let
      config-installer = {
        modules = {
          better-nix.enable = true;
          remove-docs.enable = true;
          openssh.enable = true;
          zfs.enable = true;
        };
        programs.git.enable = true;
        services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";
      };

      config-server = {
        modules = {
          better-defaults.enable = lib.mkDefault true;
          better-networking.enable = lib.mkDefault true;
          better-nix.enable = lib.mkDefault true;
          openssh.enable = lib.mkDefault true;
          remove-docs.enable = lib.mkDefault true;
          security.enable = lib.mkDefault true;
          smartd.enable = lib.mkDefault true;
          user-mateidibu.enable = lib.mkDefault true;
        };
      };

      config-headless-desktop = lib.mkMerge [
        config-server
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs;
            };
            users.mateidibu = import ../home/mateidibu;
          };
          programs.fuse.userAllowOther = true;
        }
      ];

      config-graphical-desktop = lib.mkMerge [
        config-headless-desktop
        {
          home-manager.users.mateidibu = import ../home/mateidibu/gui;
          modules = {
            audio.enable = lib.mkDefault true;
            sway.enable = lib.mkDefault true;
          };
          programs.dconf.enable = true;
          security = {
            polkit.enable = true;
            rtkit.enable = true;
          };
        }
      ];
    in
    lib.mkMerge [
      (lib.mkIf (config.modules.system-type.stype == "installer") config-installer)
      (lib.mkIf (config.modules.system-type.stype == "server") config-server)
      (lib.mkIf (config.modules.system-type.stype == "headless-desktop") config-headless-desktop)
      (lib.mkIf (config.modules.system-type.stype == "graphical-desktop") config-graphical-desktop)
    ];
}
