{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options = {
    modules.yubikey.enable = lib.mkEnableOption "sops, age, yubikey";
  };

  config = lib.mkIf config.modules.yubikey.enable { services.pcscd.enable = true; };
}
