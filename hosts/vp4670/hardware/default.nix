{ inputs, ... }:
{
  imports =
    (with inputs.nixos-hardware.nixosModules; [
      common-pc
      common-pc-ssd
      common-cpu-intel-comet-lake
    ])
    ++ [
      ./disk.nix
      ./networking.nix
    ];

  modules = {
    gpu-intel.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
