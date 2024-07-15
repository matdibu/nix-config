{ config, lib, ... }:
{
  options = {
    modules.audio.enable = lib.mkEnableOption "pipewire";
  };
  config = lib.mkIf config.modules.audio.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # disable pulseaudio
    hardware.pulseaudio.enable = false;
  };
}
