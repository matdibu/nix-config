{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      neofetch

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

      # pgp stuff
      gnupg
      pinentry
      ;
  };
}
