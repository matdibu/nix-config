{lib, ...}: let
  pool_name = "tank";
  root_snapshot_name = "${pool_name}/system/tmp@blank";
  persist_path = "/mnt/persist";
in {
  imports = [
    ./openssh.nix
  ];

  # Don't allow mutation of users outside of the config.
  users.mutableUsers = false;

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r ${root_snapshot_name}
  '';

  fileSystems.${persist_path}.neededForBoot = true;
}
