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

      # build shell scripts for nixos-rebuild on each host, named "nixos-rebuild-$host"
      apps =
        let
          real-hosts = lib.attrsets.filterAttrs (
            name: _value: (!hasPrefix "iso-" name && !hasPrefix "sd-card-" name)
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
            name = "nixos-rebuild-${host}";
            value.program = toString (pkgs.writeShellScript "nixos-rebuild-${host}" (script host cfg));
          }) real-hosts
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
          }) real-hosts
        )
        // (
          let
            script = f: _hosts: ("set -ex\n" + concatLines (mapAttrsToList f _hosts));
            nixosRebuildHost = host: _cfg: inputs.self.apps.${system}."nixos-rebuild-${host}".program;
            rebootHost = host: _cfg: inputs.self.apps.${system}."reboot-${host}".program;
          in
          {
            "nixos-rebuild-all".program = toString (
              pkgs.writeShellScript "nixos-rebuild-all" (script nixosRebuildHost real-hosts)
            );
            "reboot-all".program = toString (pkgs.writeShellScript "reboot-all" (script rebootHost real-hosts));
          }
        );
    };
}
