{ pkgs, ... }:
{
  home.packages =
    (builtins.attrValues {
      inherit (pkgs)
        fastfetch

        # utilities
        zip
        xz
        unzip
        p7zip
        dnsutils
        file
        which
        tree
        zstd
        gnutar
        gnused
        btop
        git
        tig
        age
        age-plugin-yubikey

        # pgp stuff
        gnupg
        pinentry
        ;
    })
    ++ [
      (pkgs.callPackage "${pkgs.path}/pkgs/tools/security/sops" {
        buildGoModule =
          args:
          pkgs.buildGoModule (
            args
            // {
              patches = [
                (pkgs.fetchpatch {
                  url = "https://raw.githubusercontent.com/nazarewk-iac/nix-configs/2df13befc16a7109754c603823ea24ae226485d9/modules/security/secrets/sops/sops.pull-1465.patch";
                  hash = "sha256-jkq7Ue3gLuoXJKKD4fk6wNQ8Xbs7f5qB2L0kYKfJXqE=";
                })
              ];
              vendorHash = "sha256-ZslrQ1qwwzwslAvgp5egG/djI0hOeWiDTB6by3J/Log=";
            }
          );
      })
    ];
}
