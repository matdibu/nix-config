{ inputs, ... }: {
  imports = (with inputs.nixos-hardware.nixosModules; [
    common-pc
    common-pc-ssd
    common-cpu-amd-pstate
  ])
  ++ (with inputs.self.nixosModules; [
    profiles-zfs
    profiles-amd-ucode
    profiles-nvidia
  ])
  ++ [
    ./impermanence.nix
    ./networking.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.kernelModules = [ "nvme" ];

  hardware.enableAllFirmware = true;

  impermanence.device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNF0M943331J";
}
