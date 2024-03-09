{inputs, ...}: let
  device = "/dev/disk/by-path/pci-0000:00:07.0";
  # persist_path = "/mnt/persist";
in {
  # disko.devices.disk."root".device = device;

  imports = [
./OLD.nix
  ];
}
