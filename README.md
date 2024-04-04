# nix-config

NixOS configurations for multiple hosts:
- `nix-x570`: Desktop PC, Ryzen 9 5950X, Asus Pro WS X570-ACE, RTX 3080
- `nix-ws`: VM hosted in `nix-hv`, with RTX 3080 passed through
- `nix-starbook`: StarLabs StarBook MkVIr2
- `nix-rockpro64`: PINE64 ROCKPro64, 8GB
- `nix-vp4670`: Protectli Vault VP4670
- `nix-iso`: personalised installer ISO

Project structure:
- `dev`: project helpers and tools
- `home`: `home-config` user settings
- `hosts`: NixOS machines
- `nixosModules`, defined with `options` and `config`
- `profiles`, aka configuration-only modules

