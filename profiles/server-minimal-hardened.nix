{ modulesPath, ... }: {
  imports = [
    "${modulesPath}/profiles/hardened.nix"
    "${modulesPath}/profiles/minimal.nix"
  ];

  security = {
    # cannot connect via ssh if this is enabled (by the hardened profile)
    lockKernelModules = false;

    allowSimultaneousMultithreading = true;
    apparmor.enable = false;
  };
}
