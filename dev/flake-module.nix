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

              # default to 'boot'
              if [[ -n "$1" ]]; then
                TASK="$1"
              else
                TASK="boot"
              fi

              # force pseudo-terminal allocation (man 1 ssh)
              export NIX_SSHOPTS="-tt"

              # run nixos-rebuild
              ${lib.getExe pkgs.nixos-rebuild} \
                "$TASK" \
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
            forEachTargetHost = f: ("set -ex\n" + concatLines (mapAttrsToList f hosts));
            deployHost = host: _cfg: inputs.self.apps.${system}."deploy-${host}".program;
            rebootHost = _host: cfg: ''
              ssh ${user}@${cfg.config.networking.hostName}.lan -tt -- \
              sudo systemctl reboot --when='+1minute'
            '';
          in
          {
            "deploy-all".program = toString (pkgs.writeShellScript "deploy-all" (forEachTargetHost deployHost));
            "reboot-all".program = toString (pkgs.writeShellScript "reboot-all" (forEachTargetHost rebootHost));
          }
        );
    };
}
