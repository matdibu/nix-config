{
  lib,
  inputs,
  config,
  ...
}: 


let
  sshHostKeys = builtins.catAttrs "path" config.services.openssh.hostKeys;
  persist_path = "/mnt/persist";
in
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  config = lib.mkMerge [
{
  # Don't allow mutation of users outside of the config.
  users.mutableUsers = false;

  # set machine id for log continuity
  environment.etc.machine-id.source = ./machine-id;

  fileSystems.${persist_path}.neededForBoot = true;

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
    {
      environment.persistence.${persist_path} = {
        hideMounts = true;
        directories = [
          "/var/log"
          # "/var/lib/systemd/coredump"
          # "/tmp" # Make builds not crash by running them on disk instead of RAM (We still clean /tmp on boot)
        ];
        files =
          [
            # "/etc/machine-id"
          ]
          ++ sshHostKeys;
      };
    }
    # (lib.optionalAttrs (options ? age) {age.identityPaths = map (x: "/nix/persistent" + x) sshHostKeys;})
  ];

}

