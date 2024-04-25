{ inputs, ... }:
{
  imports =
    (with inputs.nixos-hardware.nixosModules; [
      common-pc
      common-pc-ssd
      common-cpu-amd-pstate
    ])
    ++ [
      ./disk-rootfs.nix
      ./disk-nas.nix
      ./networking.nix
    ];

  modules = {
    gpu-nvidia.enable = true;
  };

  hardware.cpu.amd.updateMicrocode = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  powerManagement.cpuFreqGovernor = "performance";
}
