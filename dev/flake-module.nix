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
          buildHost = self.nixosConfigurations.x570.configuration.networking.hostName;
          script = host: cfg: ''
            set -x

            # default to 'switch'
            if [[ -n "$1" ]]; then
              TASK="$1"
            else
              TASK="switch"
            fi

            # force pseudo-terminal allocation (man 1 ssh)
            ${lib.optionalString cfg.config.security.sudo.wheelNeedsPassword "export NIX_SSHOPTS=-tt"}

            # run nixos-rebuild
            ${lib.getExe (pkgs.nixos-rebuild.override { nix = pkgs.nixUnstable; })} \
              "$TASK" \
              --fast \
              --flake ${inputs.self}#${host} \
              --use-remote-sudo \
              --target-host ${host}.lan \
              --build-host "${buildHost}.lan"
              # temporarily use ${buildHost} for all builds, since it's the most powerful
          '';
        in
        lib.mapAttrs' (host: cfg: {
          name = "deploy-${host}";
          value.program = toString (pkgs.writeShellScript "deploy-${host}" (script host cfg));
        }) inputs.self.nixosConfigurations;
    };
}
