{
  config,
  inputs,
  lib,
  ...
}:
{
  options = {
    modules.system-type = {
      stype = lib.mkOption {
        type = lib.types.enum [
          "none"
          "server"
          "headless-desktop"
          "graphical-desktop"
        ];
        default = "none";
      };
    };
  };

    imports = [ inputs.home-manager.nixosModule ];

  config =
    let
      config-none = { };
      config-server = config-none // {
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
      config-headless-desktop = config-server // {
                # imports = [ inputs.home-manager.nixosModule ];
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit inputs;
          };
          users.mateidibu = import ../home/mateidibu;
        };
        programs.fuse.userAllowOther = true;
      };
      config-graphical-desktop = config-headless-desktop // {
                # imports = [ inputs.home-manager.nixosModule ];
        home-manager = {
          users.mateidibu = import ../home/mateidibu/gui;
        };
        modules = {
          audio.enable = true;
          sway.enable = true;
        };
        programs.dconf.enable = true;
        security = {
          polkit.enable = true;
          rtkit.enable = true;
        };
      };
    in
    (lib.mkIf (config.modules.system-type.stype == "none") config-none)
    // (lib.mkIf (config.modules.system-type.stype == "server") config-server)
    // (lib.mkIf (config.modules.system-type.stype == "headless-desktop") config-headless-desktop)
    // (lib.mkIf (config.modules.system-type.stype == "graphical-desktop") config-graphical-desktop);
}
