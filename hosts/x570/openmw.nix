{
  nixpkgs.overlays = [

    #(final: prev: {
    #  mygui = prev.mygui.overrideAttrs (_: {
    #    version = "3.4.3";

    #    src = prev.fetchFromGitHub {
    #      owner = "MyGUI";
    #      repo = "mygui";
    #      rev = "MyGUI${final.mygui.version}";
    #      hash = "sha256-qif9trHgtWpYiDVXY3cjRsXypjjjgStX8tSWCnXhXlk=";
    #    };
    #    patches = [];
    #    # cmakeFlags = prev.mygui.cmakeFlags ++ ["-DMYGUI_STATIC=ON"];
    #  });
    #})

    (_: prev: {
      openmw = prev.openmw.overrideAttrs (_: {
        version = "nightly";
        src = prev.fetchFromGitLab {
          owner = "OpenMW";
          repo = "openmw";
          rev = "7ac402390a80f04afbcaf54d35bb9676403ae2ea";
          hash = "sha256-Vq6TFzM/2QYvic8d5Yl5kO2JkWDVmtT8tm9WBAZEwtM=";
        };
        nativeBuildInputs = with prev; [
          cmake
          pkg-config
          libsForQt5.qt5.qttools
        ];
        dontWrapQtApps = true;
        # cmakeFlags = prev.openmw.cmakeFlags ++ ["-DMYGUI_STATIC=ON"];
      });
    })
  ];
}
