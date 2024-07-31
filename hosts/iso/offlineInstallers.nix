{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  targets = lib.filter (
    name:
    (
      let
        isSameArch =
          inputs.self.nixosConfigurations.${name}.config.nixpkgs.hostPlatform.system
          == config.nixpkgs.hostPlatform.system;
      in
      !lib.strings.hasPrefix "iso-" name && isSameArch
    )
  ) (lib.attrNames inputs.self.nixosConfigurations);
in
{
  environment.etc."install-closure".source =
    let
      targetDerivations = target: [
        inputs.self.nixosConfigurations.${target}.config.system.build.toplevel
        inputs.self.nixosConfigurations.${target}.config.system.build.diskoScript
        inputs.self.nixosConfigurations.${target}.config.system.build.diskoScript.drvPath
        inputs.self.nixosConfigurations.${target}.pkgs.stdenv.drvPath
        (inputs.self.nixosConfigurations.${target}.pkgs.closureInfo { rootPaths = [ ]; }).drvPath
      ];

      flakeInputsDerivations = builtins.map (i: i.outPath) (builtins.attrValues inputs.self.inputs);

      dependencies = (lib.concatMap targetDerivations targets) ++ flakeInputsDerivations;

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
}
