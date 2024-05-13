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
      inherit (lib.attrsets) mapAttrsToList;
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
          nixfmt-rfc-style.enable = true;
          deadnix.enable = true;
          statix.enable = true;
        };
        settings.formatter = {
          statix.excludes = [ "auto-generated.nix" ];
        };
      };

      # build shell scripts for deployment on each host, named "deploy-$host"
      apps =
        let
          hosts = lib.attrsets.filterAttrs (
            name: value:
            (
              !hasPrefix "iso-" name
              && !hasPrefix "sd-card-" name
              && value.config.nixpkgs.buildPlatform.system == system
            )
          ) inputs.self.nixosConfigurations;
          user = "mateidibu";
        in
        (
          let
            script = host: cfg: ''
              set -ex

              TASK_DEFAULT="boot"
              if [[ -n "$1" ]]; then
                TASK="$1"
              else
                TASK="$TASK_DEFAULT"
              fi

              # force pseudo-terminal allocation (man 1 ssh)
              # export NIX_SSHOPTS="-tt"

              # run nixos-rebuild
              ${lib.getExe pkgs.nixos-rebuild} \
                "$TASK" \
                --max-jobs 1 \
                --fast \
                --flake ${inputs.self}#${host} \
                --use-remote-sudo \
                --target-host "${user}@${cfg.config.networking.hostName}.lan"
            '';
          in
          lib.mapAttrs' (host: cfg: {
            name = "deploy-${host}";
            value.program = toString (pkgs.writeShellScript "deploy-${host}" (script host cfg));
          }) hosts
        )
        // (
          let
            script = _host: cfg: ''
              set -ex

              WHEN_DEFAULT="+1minute"
              if [[ -n "$1" ]]; then
                WHEN="$1"
              else
                WHEN="$WHEN_DEFAULT"
              fi

              ssh "${user}@${cfg.config.networking.hostName}.lan" -tt -- \
                sudo systemctl reboot --when=$WHEN
            '';
          in
          lib.mapAttrs' (host: cfg: {
            name = "reboot-${host}";
            value.program = toString (pkgs.writeShellScript "reboot-${host}" (script host cfg));
          }) hosts
        )
        // (
          let
            script = f: ("set -ex\n" + concatLines (mapAttrsToList f hosts));
            deployHost = host: _cfg: inputs.self.apps.${system}."deploy-${host}".program;
            rebootHost = host: _cfg: inputs.self.apps.${system}."reboot-${host}".program;
          in
          {
            "deploy-all".program = toString (pkgs.writeShellScript "deploy-all" (script deployHost));
            "reboot-all".program = toString (pkgs.writeShellScript "reboot-all" (script rebootHost));
          }
        );
    };
}
