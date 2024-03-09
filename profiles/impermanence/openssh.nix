{
  lib,
  config,
  ...
}: let
  persist_path = "/mnt/persist";
in {
  services.openssh = lib.mkIf config.services.openssh.enable {
    hostKeys = [
      {
        path = "${persist_path}/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "${persist_path}/ssh/ssh_host_rsa_key";
        type = "rsa";
        # bits=4096; # not impermanence-relevant
      }
    ];
  };
}
