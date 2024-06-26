{ lib, ... }:
{
  modules = {
    better-nix.enable = true;
    remove-docs.enable = true;
    openssh.enable = true;
    zfs.enable = true;
  };

  programs.git.enable = true;

  services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";
}
