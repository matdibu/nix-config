_: let
  persist_path = "/mnt/persist";
in {
  imports = [
    ./openssh.nix
  ];

  # Don't allow mutation of users outside of the config.
  users.mutableUsers = false;

  fileSystems.${persist_path}.neededForBoot = true;

  boot.zfs.extraPools = ["tank"];
}
