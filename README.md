# nix-config

NixOS configurations for multiple hosts:
- `iso`: modified installer ISO, for both x86_64 and AArch64
- `rockpro64`: PINE64 ROCKPro64 4GB
- `rpi4`: RaspberryPi 4B 4GB
- `sd-card`: modified sd-card image for AArch64
- `vp4670`: Protectli Vault VP4670
- `ws`: VM hosted within `nix-hv`, with RTX 3080 passed through
- `x570`: Desktop PC, Ryzen 9 5950X, Asus Pro WS X570-ACE, RTX 3080

Project structure:
- `dev`: project helpers and tools
- `home`: `home-config` user settings
- `hosts`: NixOS machines
- `nixosModules`, defined with `options` and `config`
- `profiles`, aka configuration-only modules
