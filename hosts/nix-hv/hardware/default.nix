{inputs, ...}: {
  imports = with inputs.nixos-hardware.nixosModules;
    [
      common-pc
      common-pc-ssd
      common-cpu-amd-pstate
    ]
    ++ (with inputs.self.nixosModules; [
      profiles-amd-ucode
    ])
    ++ [
      ./networking.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  impermanence.device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNF0M943331J";
}
