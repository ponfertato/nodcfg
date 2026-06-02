# <img src="https://upload.wikimedia.org/wikipedia/commons/2/28/Nix_snowflake.svg" width="50" height="50"> Nix-on-Droid Modular Configuration

✨ **Declarative mobile environment with Flakes**
📱 _Snowflake-inspired infrastructure for your Android devices_

---

## 🚀 Quick Start

### Requirements
- **Android device** with [Nix-on-Droid](https://github.com/nix-community/nix-on-droid) installed from F-Droid
- **Git** available on the device (can be installed via `nix run nixpkgs#git`)
- **NixOS 24.05** compatible flake inputs

### Initial Setup
```bash
# Clone the repository
nix run nixpkgs#git -- clone https://codeberg.org/ponfertato/nodcfg ~/.config/nixpkgs
cd ~/.config/nixpkgs

# Build and activate configuration for your device
nix-on-droid switch --flake ~/.config/nixpkgs#potatoPhone
# or
nix-on-droid switch --flake ~/.config/nixpkgs#potatoTablet
```

---

## 📂 Structure
```text
nodcfg/
├── flake.nix                          # ❄️ Nix-on-Droid entry point + unstable overlay
├── profiles/                          # 🧩 Modular system profiles
│   ├── core/                          # 🖥️ Base: locale, nix settings, common packages
│   │   └── default.nix
│   └── user/                          # 👤 User roles (multi-user ready)
│       └── ponfertato/                # 👤 Current user profile
│           └── default.nix            #    Git config, shell aliases, user packages
└── hosts/                             # 📱 Host-specific configs
    ├── potatoPhone/                   # 📱 Phone-specific packages
    │   └── default.nix
    └── potatoTablet/                  # 📱 Tablet-specific packages
        └── default.nix
```

### Symmetry with `nixcfg`

| Path in `nixcfg` (NixOS) | Path in `nodcfg` (Nix-on-Droid) |
|---|---|
| `profiles/core/` | `profiles/core/` |
| `profiles/user/ponfertato/` | `profiles/user/ponfertato/` |
| `hosts/potatoWork/`, `hosts/potatoLaptop/` | `hosts/potatoPhone/`, `hosts/potatoTablet/` |

The same mental model applies to both repositories — only the system-level options differ (`environment.systemPackages` vs `environment.packages`, `programs.firefox` vs `environment.etc."gitconfig"`, etc.).

---

## 🔄 Maintenance

### Apply configuration (recommended)
```bash
nix-od
```

### Update flake inputs
```bash
nix-update
```

### Full update workflow
```bash
nix-update && nix-check && nix-od
```

### Rollback to previous generation
```bash
nix-roll
```

### Garbage Collection
```bash
nix-gc
```

### Validate configuration
```bash
nix-check
```

### Manual Update (if needed)
```bash
# Update flake inputs
nix flake update
# Rebuild and activate
nix-on-droid switch --flake ~/.config/nixpkgs#$(hostname)
```

### Package Search
```bash
nix search nixpkgs <package>          # in stable (nixos-24.05)
nix search nixpkgs-unstable <package> # in unstable
```

---

## ✨ Key Features

- 📱 **Multi-Device Support**: Share base config across `potatoPhone` and `potatoTablet`
- 🛡️ **Reproducible Builds**: Fully declarative configuration with Flakes
- ⚙️ **Optimized Nix Settings**: Yandex mirror + custom substituters for faster builds
- 🔥 **Unstable Overlay**: Access `pkgs.unstable.*` without extra args
- 👤 **No Home Manager**: Pure Nix-on-Droid via `environment.packages`, `environment.etc`, `env.shellInit`
- 🔄 **Easy Rollback**: `nix-roll` to revert to previous generation
- 🧹 **Auto GC**: Weekly garbage collection
- 🔀 **Symmetric with `nixcfg`**: Same folder layout for easy navigation

---

## 🛠️ Customization

### Add a new device
1. Add `hosts/<device_name>/default.nix`
2. Register it in `flake.nix` under `nixOnDroidConfigurations`
3. Apply: `nix-on-droid switch --flake .#<device_name>`

### Add packages
- **Common packages** (all devices): edit `profiles/core/default.nix`
- **User-specific packages**: edit `profiles/user/ponfertato/default.nix`
- **Device-specific packages**: edit `hosts/<device_name>/default.nix`

### Modify user settings
- **Git config**: `profiles/user/ponfertato/default.nix` → `environment.etc."gitconfig"`
- **Git ignores**: `profiles/user/ponfertato/default.nix` → `environment.etc."gitignore_global"`
- **Shell aliases**: `profiles/user/ponfertato/default.nix` → `env.shellInit`

### Add a new user role
1. Create `profiles/user/<username>/default.nix`
2. Import it from the desired host instead of `ponfertato`
