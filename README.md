       _               
      (_)              
 _ __  ___  _____  ___ 
| '_ \| \ \/ / _ \/ __|
| | | | |>  < (_) \__ \
|_| |_|_/_/\_\___/|___/
                       
                       

# NixOS Dotfiles
- **Maintainer / Contributor**: KaayZouee.

## Updates:
- Removed hardware.configuration.nix
- Minor debloat + network / virtualization tweak and many more

> Notes:  From now on, minor changes to README.md won’t be tracked in the Updates section.

### ✅ Portable (can be reused anywhere):
- `flake.nix` → Main flake configuration (system + modules + packages).
- `configuration.nix` → Base system configuration (users, services, desktop, etc.).

These are safe to share and can be reused on other machines (with minor adjustments).

> Note: I'm planning to move from classic configuration.nix to flake.nix, not sure if that's a good choice or not. Only small updates from now on.
