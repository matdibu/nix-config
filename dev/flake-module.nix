{ inputs, self, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    {
      pkgs,
      lib,
      inputs',
      ...
    }:
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
          hosts = lib.attrsets.filterAttrs(
            name: value: (!lib.strings.hasInfix "iso" name && !lib.strings.hasInfix "sd-card" name && value.config.nixpkgs.buildPlatform.system == "x86_64-linux")
          ) inputs.self.nixosConfigurations;
        in
        (
          let
            user = "mateidibu";
            script = host: cfg: ''
              set -x

              # default to 'boot'
              if [[ -n "$1" ]]; then
                TASK="$1"
              else
                TASK="boot"
              fi

              # force pseudo-terminal allocation (man 1 ssh)
              # export NIX_SSHOPTS="-tt"

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
            hostNames = lib.mapAttrsToList (name: _value: name) hosts;
            script =
              "set -x\n" + lib.strings.concatLines (map (host: inputs.self.apps."x86_64-linux"."deploy-${host}".program) hostNames);
          in
          {
            "deploy-all".program = toString (pkgs.writeShellScript "deploy-all" script);
          }
        );
    };
}
