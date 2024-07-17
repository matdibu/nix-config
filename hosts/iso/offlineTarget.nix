{
  inputs,
  pkgs,
  lib,
  offlineTarget,
  ...
}:
{
  config = lib.mkIf (offlineTarget != null) {

    environment.etc."install-closure".source =
      let
        dependencies = [
          inputs.self.nixosConfigurations.${offlineTarget}.config.system.build.toplevel
          inputs.self.nixosConfigurations.${offlineTarget}.config.system.build.diskoScript
          inputs.self.nixosConfigurations.${offlineTarget}.config.system.build.diskoScript.drvPath
          inputs.self.nixosConfigurations.${offlineTarget}.pkgs.stdenv.drvPath
          (inputs.self.nixosConfigurations.${offlineTarget}.pkgs.closureInfo { rootPaths = [ ]; }).drvPath
        ] ++ builtins.map (i: i.outPath) (builtins.attrValues inputs.self.inputs);

        closureInfo = pkgs.closureInfo { rootPaths = dependencies; };
      in
      "${closureInfo}/store-paths";

    environment.systemPackages = [
      (pkgs.writeShellScriptBin "install-nixos-unattended" ''
        set -eux
        exec ${pkgs.disko}/bin/disko-install --flake "${inputs.self}#${offlineTarget}" --disk "root-disk" ${
          inputs.self.nixosConfigurations.${offlineTarget}.config.disko.devices.disk."root-disk".device
        }
      '')
    ];
  };
}
