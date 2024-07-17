{ lib, config, ... }:
let
  cfg = config.modules.oci-containers;
in
{
  options = {
    modules.oci-containers = {
      enable = lib.mkEnableOption "oci-containers";
      storage-path = lib.mkOption {
        type = lib.types.str;
        default = "/mnt/containers";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
      defaultNetwork.settings = {
        # Required for container networking to be able to use names.
        dns_enabled = true;
      };
    };

    virtualisation.oci-containers.backend = "podman";
  };
}
