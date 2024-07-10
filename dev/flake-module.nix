{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    {
      pkgs,
      lib,
      inputs',
      system,
      ...
    }:
    let
      inherit (lib.strings) hasPrefix concatLines;
    in
    {
      devShells.default = pkgs.mkShellNoCC {
        packages = [
          inputs'.agenix.packages.agenix
          pkgs.age-plugin-yubikey
        ];
      };

      treefmt = {
        projectRootFile = "flake.nix";
        programs = {
          nixfmt.enable = true;
          deadnix.enable = true;
          statix.enable = true;
        };
      };

      apps =
        let
          real-hosts = lib.filter (name: (!hasPrefix "iso-" name && !hasPrefix "sd-card-" name)) (
            lib.attrNames inputs.self.nixosConfigurations
          );
          user = "mateidibu";

          nixos-rebuild-script = host: ''
            set -ex

            TASK_DEFAULT="boot"
            if [[ -n "$1" ]]; then
              TASK="$1"
            else
              TASK="$TASK_DEFAULT"
            fi

            ${lib.getExe pkgs.nixos-rebuild} \
              "$TASK" \
              --accept-flake-config \
              --max-jobs 1 \
              --fast \
              --flake ${inputs.self}#${host} \
              --use-remote-sudo \
              --target-host "${user}@${host}.lan"
          '';
        in
        lib.listToAttrs (
          lib.map (host: {
            name = "nixos-rebuild-${host}";
            value.program = toString (
              pkgs.writeShellScript "nixos-rebuild-${host}" (nixos-rebuild-script host)
            );
          }) real-hosts
        )
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
          lib.listToAttrs (
            lib.map (host: {
              name = "reboot-${host}";
              value.program = toString (pkgs.writeShellScript "reboot-${host}" (reboot-script host));
            }) real-hosts
          )
        )
        // (
          let
            nixos-rebuild-all = hosts: ''
              set -x
              # do the builds before deploying, to batch the 2FA requests at the end
              ${concatLines (lib.map host-to-prebuild-command hosts)}
              ${concatLines (lib.map host-to-rebuild-app hosts)}
            '';

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
            "nixos-rebuild-all".program = toString (
              pkgs.writeShellScript "nixos-rebuild-all" (nixos-rebuild-all real-hosts)
            );
          }
        )
        // (
          let
            reboot-all = hosts: ''
              set -x
              ${concatLines (lib.map host-to-reboot-app hosts)}
            '';

            host-to-reboot-app = host: (inputs.self.apps.${system}."reboot-${host}".program + " $@");
          in
          {
            "reboot-all".program = toString (pkgs.writeShellScript "reboot-all" (reboot-all real-hosts));
          }
        );
    };
}
