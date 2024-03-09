{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # disable pulseaudio
  hardware.pulseaudio.enable = false;

  # disable ALSA
  sound.enable = false;
}
