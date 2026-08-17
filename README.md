# ltcSway-os

A personal Fedora Atomic desktop image for Sway, built on [wayblue](https://github.com/wayblueorg/wayblue). Targets a middle ground between a minimal Fedora Sway Atomic install and full-featured gaming distributions like Nobara or Bazzite. Designed for daily development work with light gaming on the side.

## About

Fedora Sway Atomic gives you a clean, minimal tiling desktop. Nobara and Bazzite give you a tuned gaming experience with everything pre-configured. This image sits between those two. It takes the wayblue Sway base — which provides sensible defaults for a working Wayland desktop without extra opinion — and layers on the tools and applications I actually use.

The image includes development tools, media applications, and a gaming stack with gamescope and the scx_lavd scheduler. It does not aim to be a general-purpose distribution. It is the system I want to run on my own machine.

Credit to the [wayblue](https://github.com/wayblueorg/wayblue) project. Their Sway image provides a clean foundation with sane defaults for waybar, SDDM, and the surrounding tooling. Building on top of it saves a lot of work while keeping the base minimal.

## Technical breakdown

### Base

- **Base image**: `ghcr.io/wayblueorg/sway`
- **Build system**: [BlueBuild](https://blue-build.org/)
- **Recipe**: `recipe.yml`
- **Builds**: GitHub Actions, daily at 06:00 UTC
- **Updates**: Automatic via `ublue-update`

### Package management

The image uses three layers for package management:

| Layer | Purpose | Examples |
|---|---|---|
| dnf | Gaming and scheduler packages (with dependency resolution) | `gamescope`, `scx-scheds`, `steam` |
| rpm-ostree | System packages | `zsh`, `gammastep` |
| Flatpak | Desktop applications | Firefox, Discord, Spotify, mpv, Chromium |
| Homebrew | User-space development tools | `stow`, `neovim` |

Homebrew installs to `/var/home/linuxbrew/` on first boot. A Brewfile at `/usr/share/brew/Brewfile` runs on first login to install user tools. The `ublue-os/brew` OCI image provides the base Homebrew installation with auto-update timers.

### Gaming

| Component | Source | Purpose |
|---|---|---|
| Gamescope | Fedora repos | Microcompositor for mouse grabbing and FPS capping |
| scx-scheds | CachyOS COPR (`bieszczaders/kernel-cachyos-addons`) | Provides `scx_lavd`, the default system scheduler |
| Steam | RPM Fusion (via dnf) | Gaming platform, native RPM for gamescope integration |

scx_lavd runs as a systemd service on boot via `scx_loader`. It is a latency-aware scheduler designed for gaming and interactive workloads. The scheduler is configured in `/etc/scx_loader/config.toml`.

Gamescope runs in nested mode inside Sway. Use it to wrap games for mouse grabbing and frame rate limiting:

```
gamescope --rt -r 60 -- steam
```

### Scripts

Scripts in `files/scripts/` run during image build:

| Script | Purpose |
|---|---|
| `clone-dotfiles.sh` | Clones personal dotfiles to `/etc/skel/repos/dotfiles` |
| `addbrewjustimport.sh` | Imports `brew.just` recipes into the system justfile |
| `install-brew-packages.sh` | Creates a profile script that runs `brew bundle` on first login |

### System files

Files in `files/system/` copy into the image root:

| Path | Purpose |
|---|---|
| `/usr/share/brew/Brewfile` | Brewfile for first-login package install |
| `/etc/scx_loader/config.toml` | scx_lavd scheduler configuration |
| `/etc/rpm-ostreed.conf` | rpm-ostree daemon configuration |

### Flatpaks

Pre-installed applications:

| Application | Purpose |
|---|---|
| Firefox | Browser |
| Chromium | Browser |
| Discord | Communication |
| Spotify | Music |
| Stremio | Media |
| Transmission | Torrents |
| mpv | Video playback |
| ProtonUp-Qt | Proton GE version management |
| `codecs-extra` | Additional media codecs |

### Security

The image is signed with Sigstore. Signing policies enable secure OSTree updates.

### First boot

1. `brew-setup.service` extracts Homebrew to `/var/home/linuxbrew/`
2. `scx_loader.service` starts scx_lavd scheduler
3. On first login, a profile script runs `brew bundle` to install user tools
4. Dotfiles are cloned into `~/repos/dotfiles`

### Repo structure

```
recipe.yml                  BlueBuild recipe
files/
  scripts/                  Build-time scripts
  system/                   Files copied into image root
    etc/scx_loader/         scx_lavd scheduler config
    usr/share/brew/         Brewfile
modules/                    (reserved for BlueBuild module overrides)
.github/workflows/build.yml  CI pipeline
```

## Building

Fork this repo and edit `recipe.yml`. The GitHub Action builds and signs the image automatically.

## License

Upstream projects retain their licenses. Everything else including my dotfiles are MIT unless noted otherwise.
