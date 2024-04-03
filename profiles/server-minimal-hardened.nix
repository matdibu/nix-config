{ modulesPath, ... }:
{
  imports = [
    "${modulesPath}/profiles/hardened.nix"
    "${modulesPath}/profiles/minimal.nix"
  ];

  security = {
    # cannot connect via ssh if this is enabled (by the hardened profile)
    lockKernelModules = false;
    # performance loss is too major with SMT disabled
    allowSimultaneousMultithreading = true;
    # apparmor.enable = false;
  };
}
