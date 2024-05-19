{
  nixpkgs.overlays = [

    (final: prev: {
      mygui = prev.mygui.overrideAttrs (_: {
        version = "3.4.3";

        src = prev.fetchFromGitHub {
          owner = "MyGUI";
          repo = "mygui";
          rev = "MyGUI${final.mygui.version}";
          hash = "sha256-qif9trHgtWpYiDVXY3cjRsXypjjjgStX8tSWCnXhXlk=";
        };
        patches = [];
        # cmakeFlags = prev.mygui.cmakeFlags ++ ["-DMYGUI_STATIC=ON"];
      });
    })

    (_: prev: {
      openmw = prev.openmw.overrideAttrs (_: {
        version = "nightly";
        src = prev.fetchFromGitLab {
          owner = "OpenMW";
          repo = "openmw";
          rev = "c3d02c0b418299cd241485747f6406f74e6143ed";
          hash = "sha256-be/BGw33Gyk2lQuhR6wcc1k74GCYDBF11bvNewsDyJY=";
        };
        nativeBuildInputs = with prev; [
          cmake
          pkg-config
          libsForQt5.qt5.qttools
        ];
        dontWrapQtApps = true;
        cmakeFlags = prev.openmw.cmakeFlags ++ ["-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON"];
      });
    })
  ];
}
