{
  inputs,
  pkgs,
  lib,
  config,
  allHosts,
  ...
}:
let
  inherit (lib) filter attrNames;
  inherit (lib.strings) hasPrefix;
  targets = filter (
    name:
    (
      !hasPrefix "iso-" name
      && !hasPrefix "sd-card-" name
      && inputs.self.nixosConfigurations.${name}.config.nixpkgs.hostPlatform.system == config.nixpkgs.hostPlatform.system
    )
  ) (attrNames inputs.self.nixosConfigurations);
in
{
  config = lib.mkIf (allHosts == true) {

    environment.etc."install-closure".source =
      let
        inherit (lib) concatMap;
        depsPerTarget = target: [
          inputs.self.nixosConfigurations.${target}.config.system.build.toplevel
          inputs.self.nixosConfigurations.${target}.config.system.build.diskoScript
          inputs.self.nixosConfigurations.${target}.config.system.build.diskoScript.drvPath
          inputs.self.nixosConfigurations.${target}.pkgs.stdenv.drvPath
          (inputs.self.nixosConfigurations.${target}.pkgs.closureInfo { rootPaths = [ ]; }).drvPath
        ];
        dependencies =
          (concatMap depsPerTarget targets)
          ++ builtins.map (i: i.outPath) (builtins.attrValues inputs.self.inputs);

        closureInfo = pkgs.closureInfo { rootPaths = dependencies; };
      in
      "${closureInfo}/store-paths";

    environment.systemPackages =
      let
        scriptBin =
          target:
          (pkgs.writeShellScriptBin "install-nixos-unattended-${target}" ''
            set -eux
            exec ${pkgs.disko}/bin/disko-install --flake "${inputs.self}#${target}" --disk "root-disk" ${
              inputs.self.nixosConfigurations.${target}.config.disko.devices.disk."root-disk".device
            }
          '');
      in
      map scriptBin targets;
  };
}
