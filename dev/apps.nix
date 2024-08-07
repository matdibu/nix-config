{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      lib,
      system,
      ...
    }:
    {
      apps =
        let
          inherit (lib)
            filter
            map
            attrNames
            getExe
            listToAttrs
            ;
          inherit (lib.strings) hasPrefix concatLines;
          real-hosts = filter (name: (!hasPrefix "iso-" name)) (attrNames inputs.self.nixosConfigurations);
          iso-hosts = filter (name: (hasPrefix "iso-" name)) (attrNames inputs.self.nixosConfigurations);
          user = "root";
        in
        lib.mkMerge [
          # app "nix-build-isos"
          (
            let
              host-to-iso-build-command =
                host:
                pkgs.writeShellScript "nix-build-${host}" ''
                  nix build \
                      --out-link "${host}" \
                      .#nixosConfigurations."${host}".config.system.build.isoImage
                '';
            in
            {
              "nix-build-isos".program = pkgs.writeShellScriptBin "nix-build-isos" ''
                set -x
                ${concatLines (map host-to-iso-build-command iso-hosts)}
              '';
            }
          )
          # app "nix-build-all-hosts"
          (
            let
              host-to-build-command =
                host:
                pkgs.writeShellScript "nix-build-${host}" ''
                  nix build \
                      --no-link \
                      .#nixosConfigurations."${host}".config.system.build.toplevel
                '';
            in
            {
              "nix-build-all-hosts".program = pkgs.writeShellScriptBin "nix-rebuild-all" ''
                set -x
                ${concatLines (map host-to-build-command real-hosts)}
              '';
            }
          )
          # apps "nixos-rebuild-${system}"
          (
            let
              nixos-rebuild-script = host: ''
                set -ex

                TASK_DEFAULT="boot"
                if [[ -n "$1" ]]; then
                  TASK="$1"
                  shift
                else
                  TASK="$TASK_DEFAULT"
                fi

                ${getExe pkgs.nixos-rebuild} \
                  "$TASK" \
                  --accept-flake-config \
                  --max-jobs 1 \
                  --fast \
                  --flake ${inputs.self}#${host} \
                  --target-host "${user}@${host}.lan" \
                  $@
              '';
            in
            listToAttrs (
              map (host: {
                name = "nixos-rebuild-${host}";
                value.program = pkgs.writeShellScriptBin "nixos-rebuild-${host}" (nixos-rebuild-script host);
              }) real-hosts
            )
          )
          # app "nixos-rebuild-all"
          (
            let
              host-to-rebuild-app = host: (inputs.self.apps.${system}."nixos-rebuild-${host}".program + " $@");
            in
            {
              "nixos-rebuild-all".program = pkgs.writeShellScriptBin "nixos-rebuild-all" ''
                set -x
                # do the builds before deploying, to batch the 2FA requests at the end
                ${inputs.self.apps.${system}."nix-build-all-hosts".program} $@
                ${concatLines (map host-to-rebuild-app real-hosts)}
              '';
            }
          )
          # apps "reboot-${system}"
          (
            let
              reboot-script = host: ''
                set -ex

                WHEN_DEFAULT="+1minute"
                if [[ -n "$1" ]]; then
                  WHEN="$1"
                  shift
                else
                  WHEN="$WHEN_DEFAULT"
                fi

                ssh "${user}@${host}.lan" -tt -- \
                  systemctl reboot --when=$WHEN $@
              '';
            in
            listToAttrs (
              map (host: {
                name = "reboot-${host}";
                value.program = pkgs.writeShellScriptBin "reboot-${host}" (reboot-script host);
              }) real-hosts
            )
          )
          # app "reboot-all"
          (
            let
              host-to-reboot-app = host: (inputs.self.apps.${system}."reboot-${host}".program + " $@");
            in
            {
              "reboot-all".program = pkgs.writeShellScriptBin "reboot-all" ''
                set -x
                ${concatLines (map host-to-reboot-app real-hosts)}
              '';
            }
          )
        ];
    };
}
