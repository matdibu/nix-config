{ pkgs, ... }: {
  # nixpkgs.overlays = [
  #   (
  #     _final: prev: {
  #       qemu_kvm = prev.qemu_kvm.override {
  #         guestAgentSupport = false;
  #         smartcardSupport = false;
  #         tpmSupport = false;
  #         # no sound support
  #         alsaSupport = false;
  #         jackSupport = false;
  #         pulseSupport = false;
  #         pipewireSupport = false;
  #         # no graphics support
  #         sdlSupport = false;
  #         gtkSupport = false;
  #         openGLSupport = false;
  #         virglSupport = false;
  #         vncSupport = false;
  #         spiceSupport = false;
  #       };
  #     }
  #   )
  # ];
  environment.systemPackages = with pkgs; [ qemu_kvm ];
}
