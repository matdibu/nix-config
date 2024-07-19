{ lib, ... }:
{
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
}
