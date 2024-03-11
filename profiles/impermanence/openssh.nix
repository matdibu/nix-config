{
  lib,
  config,
  ...
}: let
  persist_path = "/mnt/persist";
in {
  environment.persistence.${persist_path} = lib.mkIf config.services.openssh.enable {
    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key"
    ];
  };
}
