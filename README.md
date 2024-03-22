# nix-config

NixOS configurations for multiple hosts:
- `nix-hv`: Desktop PC, Ryzen 9 5950X, Asus Pro WS X570-ACE, RTX 3080
- `nix-ws`: VM hosted in `nix-hv`, with RTX 3080 passed through
- `nix-rockpro64`: PINE64 ROCKPro64, 8GB
- `nix-vp4670`: Protectli Vault VP4670
- `nix-iso`: personalised installer ISO

Project structure:
- `dev`: project helpers and tools
- `home`: `home-config` user settings
- `hosts`: NixOS machines
- `modules`: normal modules, defined with `options` and `config`
- `profiles`: configuration-only modules

