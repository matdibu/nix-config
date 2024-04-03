{ inputs, ... }:
{
  imports = (with inputs.self.nixosModules; [ profiles-qemu-guest ]) ++ [
    ./networking.nix
    ./disk.nix
  ];

  modules.gpu-nvidia.enable = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
