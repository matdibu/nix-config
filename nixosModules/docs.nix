{ lib, config, ... }: {
  options = {
    modules.remove-docs.enable = lib.mkEnableOption "remove docs and man pages" // { default = true; };
  };
  config = lib.mkIf config.modules.remove-docs.enable {
    # For `info` command.
    documentation.info.enable = false;

    # NixOS manual and such.
    documentation.nixos.enable = false;

    programs.command-not-found.enable = false;
  };
}
