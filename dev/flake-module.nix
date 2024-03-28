{ inputs, ... }: {
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = { pkgs, lib, inputs', ... }: {
    devShells.default = pkgs.mkShellNoCC {
      packages = [ inputs'.agenix.packages.agenix pkgs.age-plugin-yubikey ];
    };

    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = true;
        deadnix.enable = true;
        statix.enable = true;
      };
    };

    # build shell scripts for deployment on each host, named "deploy-$host"
    apps = let
      buildHost = "nix-hv.lan";
      script = host: cfg: ''
        set -x

        # default to 'switch'
        if [[ -n "$1" ]]; then
          TASK="$1"
        else
          TASK="switch"
        fi

        # force pseudo-terminal allocation (man 1 ssh)
        ${lib.optionalString cfg.config.security.sudo.wheelNeedsPassword
        "export NIX_SSHOPTS=-tt"}

        # run nixos-rebuild
        ${
          lib.getExe (pkgs.nixos-rebuild.override { nix = pkgs.nixUnstable; })
        } \
          "$TASK" \
          -s \
          --use-remote-sudo \
          --fast \
          --flake ${inputs.self}#${host} \
          --target-host ${cfg.config.networking.hostName} \
          ${
            lib.optionalString
            (cfg.config.nixpkgs.hostPlatform == "aarch64-linux")
            "--build-host ${buildHost}"
          }
      '';
    in lib.mapAttrs' (host: cfg: {
      name = "deploy-${host}";
      value.program = toString
        (pkgs.writeShellScript "deploy-${host}" script { inherit host cfg; });
    }) inputs.self.nixosConfigurations;
  };
}
