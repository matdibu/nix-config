{ inputs, pkgs, ... }:

let
  overlay-replace-flashrom = final: _prev: {
    flashrom = final.callPackage inputs.flashrom-meson { };
  };
in {
  # for bios updates
  boot.kernelParams = [ "iomem=relaxed" ];

  nixpkgs.overlays = [ overlay-replace-flashrom ];

  services.fwupd = {
    enable = true;
    package = pkgs.fwupd.override { enableFlashrom = true; };
    extraRemotes = [ "lvfs-testing" ];
  };
}
