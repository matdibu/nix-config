{
  lib,
  pkgs,
  ...
}: let
  pool_name = "tank";
  root_snapshot_name = "${pool_name}/system/tmp@blank";
in {
  boot.initrd.systemd.enable = lib.mkDefault true;
  boot.initrd.systemd.services.rollback = {
    description = "Rollback root filesystem to a pristine state on boot";
    wantedBy = [
      # "zfs.target"
      "initrd.target"
    ];
    after = [
      "zfs-import-rpool.service"
    ];
    before = [
      "sysroot.mount"
    ];
    path = [
      pkgs.zfs
    ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      zfs rollback -r ${root_snapshot_name}
    '';
  };
}
