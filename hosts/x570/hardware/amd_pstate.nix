{ pkgs, ... }:
{
  boot.kernelPatches = [
    {
      name = "amd-pstate v14 1/7";
      patch = pkgs.fetchpatch {
        url = "https://patchwork.kernel.org/project/linux-kselftest/patch/20240119090502.3869695-2-li.meng@amd.com/raw/";
        hash = "sha256-FJfrFf97G1Rvst6V2m1qa+DK44kolPww+bvdsevG4oU=";
      };
    }
    {
      name = "amd-pstate v14 2/7";
      patch = pkgs.fetchpatch {
        url = "https://patchwork.kernel.org/project/linux-kselftest/patch/20240119090502.3869695-3-li.meng@amd.com/raw/";
        hash = "sha256-rslC9+N2D75mnqOYzzsqKBsmDJO2B4reufYDCw68TqA=";
      };
    }
    {
      name = "amd-pstate v14 3/7";
      patch = pkgs.fetchpatch {
        url = "https://patchwork.kernel.org/project/linux-kselftest/patch/20240119090502.3869695-4-li.meng@amd.com/raw/";
        hash = "sha256-8e8GRblNAiMSQXZDLBFUb1ElzvrJZBULuSofnwNOvN4=";
      };
    }
    {
      name = "amd-pstate v14 4/7";
      patch = pkgs.fetchpatch {
        url = "https://patchwork.kernel.org/project/linux-kselftest/patch/20240119090502.3869695-5-li.meng@amd.com/raw/";
        hash = "sha256-JtriewSAlGO4kVdtViTBFoz6N8BWu+Q5skdHjI59JL4=";
      };
    }
    {
      name = "amd-pstate v14 5/7";
      patch = pkgs.fetchpatch {
        url = "https://patchwork.kernel.org/project/linux-kselftest/patch/20240119090502.3869695-6-li.meng@amd.com/raw/";
        hash = "sha256-0pPqmt2Jk9xSFTF7Bs9PK/Tt2IU+8VbOOlBVbYOPk0w=";
      };
    }
    {
      name = "amd-pstate v14 6/7";
      patch = pkgs.fetchpatch {
        url = "https://patchwork.kernel.org/project/linux-kselftest/patch/20240119090502.3869695-7-li.meng@amd.com/raw/";
        hash = "sha256-7egRzb23Bj3DuUJx/wKWTue2opJNZWGpNEIeceNBZHw=";
      };
    }
    {
      name = "amd-pstate v14 7/7";
      patch = pkgs.fetchpatch {
        url = "https://patchwork.kernel.org/project/linux-kselftest/patch/20240119090502.3869695-8-li.meng@amd.com/raw/";
        hash = "sha256-suuF4AW2SZ2tjAaLlnRAApCKSOtaK9ZFJSa/zTzw/c8=";
      };
    }
  ];
}
