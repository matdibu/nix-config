{ inputs, ... }: {
  imports =
    (with inputs.nixos-hardware.nixosModules; [ common-pc common-pc-ssd ])
    ++ [ ./disk.nix ./networking.nix ];

  modules = { gpu-intel.enable = true; };

  hardware.cpu.intel.updateMicrocode = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
