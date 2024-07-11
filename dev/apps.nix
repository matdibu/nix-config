{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      lib,
      system,
      ...
    }:
    let
      inherit (lib)
        filter
        map
        attrNames
        getExe
        listToAttrs
        ;
      inherit (lib.strings) hasPrefix concatLines;
    in
    {
      apps =
        let
          real-hosts = filter (name: (!hasPrefix "iso-" name && !hasPrefix "sd-card-" name)) (
            attrNames inputs.self.nixosConfigurations
          );
          user = "mateidibu";
        in
        # apps "nixos-rebuild-${system}"
        (
          let
            nixos-rebuild-script = host: ''
              set -ex

              TASK_DEFAULT="boot"
              if [[ -n "$1" ]]; then
                TASK="$1"
              else
                TASK="$TASK_DEFAULT"
              fi

              ${getExe pkgs.nixos-rebuild} \
                "$TASK" \
                --accept-flake-config \
                --max-jobs 1 \
                --fast \
                --flake ${inputs.self}#${host} \
                --use-remote-sudo \
                --target-host "${user}@${host}.lan"
            '';
          in
          listToAttrs (
            map (host: {
              name = "nixos-rebuild-${host}";
              value.program = pkgs.writeShellScriptBin "nixos-rebuild-${host}" (nixos-rebuild-script host);
            }) real-hosts
          )
        )
        # apps "reboot-${system}"
        // (
          let
            reboot-script = host: ''
              set -ex

              WHEN_DEFAULT="+1minute"
              if [[ -n "$1" ]]; then
                WHEN="$1"
              else
                WHEN="$WHEN_DEFAULT"
              fi

              ssh "${user}@${host}.lan" -tt -- \
                sudo systemctl reboot --when=$WHEN
            '';
          in
          listToAttrs (
            map (host: {
              name = "reboot-${host}";
              value.program = pkgs.writeShellScriptBin "reboot-${host}" (reboot-script host);
            }) real-hosts
          )
        )
        # app "nixos-rebuild-all"
        // (
          let
            host-to-prebuild-command =
              host:
              pkgs.writeShellScript "nix-build-${host}" ''
                nix build \
                    --no-link \
                    .#nixosConfigurations."${host}".config.system.build.toplevel
              '';
            host-to-rebuild-app = host: (inputs.self.apps.${system}."nixos-rebuild-${host}".program + " $@");
          in
          {
            "nixos-rebuild-all".program = pkgs.writeShellScriptBin "nixos-rebuild-all" ''
              set -x
              # do the builds before deploying, to batch the 2FA requests at the end
              ${concatLines (map host-to-prebuild-command real-hosts)}
              ${concatLines (map host-to-rebuild-app real-hosts)}
            '';
          }
        )
        # app "reboot-all"
        // (
          let
            host-to-reboot-app = host: (inputs.self.apps.${system}."reboot-${host}".program + " $@");
          in
          {
            "reboot-all".program = pkgs.writeShellScriptBin "reboot-all" ''
              set -x
              ${concatLines (map host-to-reboot-app real-hosts)}
            '';
          }
        );
    };
}