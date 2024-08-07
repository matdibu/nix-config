{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options = {
    modules.sops.enable = lib.mkEnableOption "sops, age, yubikey";
  };

  config = lib.mkIf config.modules.sops.enable {
    services.pcscd.enable = true;
    sops = {
      defaultSopsFile = "${inputs.self}/secrets/common.yaml";
      age.sshKeyPaths = [ "/mnt/persist/etc/ssh/ssh_host_ed25519_key" ];
      gnupg.sshKeyPaths = [];
    };
  };
}
