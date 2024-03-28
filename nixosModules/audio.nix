{ config, lib, ... }: {
  options = {
    modules.audio.enable =
      lib.mkEnableOption "pipewire, emulating pulseaudio and alsa";
  };
  config = lib.mkIf config.modules.audio.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      # alsa.support32Bit = true;
      pulse.enable = true;
    };

    # disable pulseaudio
    hardware.pulseaudio.enable = false;

    # disable ALSA
    sound.enable = false;
  };
}
