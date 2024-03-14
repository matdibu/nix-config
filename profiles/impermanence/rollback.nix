{pkgs, ...}: let
  pool_name = "tank";
  root_snapshot_name = "${pool_name}/system/tmp@blank";
in {
  boot.initrd = {
    supportedFilesystems = ["zfs"]; # boot from zfs
    # availableKernelModules = ["zfs" "spl"];
    # kernelModules = ["zfs" "spl"];
    # kernelModules = ["zfs"];
    systemd = {
      enable = true;
      services = {
        rollback = {
          description = "Rollback filesystem to a pristine state on boot";
          wantedBy = [
            "zfs.target"
            "initrd.target"
          ];
          after = [
            "zfs-import-${pool_name}.service"
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
      };
    };
  };
}
