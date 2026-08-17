# ltcSway-os

A personal Fedora Atomic desktop image for Sway, built on [wayblue](https://github.com/wayblueorg/wayblue). Targets a middle ground between a minimal Fedora Sway Atomic install and full-featured gaming distributions like Nobara or Bazzite. Designed for daily development work with light gaming on the side.

## About

Fedora Sway Atomic gives you a clean, minimal tiling desktop. Nobara and Bazzite give you a tuned gaming experience with everything pre-configured. This image sits between those two. It takes the wayblue Sway base — which provides sensible defaults for a working Wayland desktop without extra opinion — and layers on the tools and applications I actually use.

The image includes development tools, media applications, and a gaming stack with gamescope and the scx_lavd scheduler. It does not aim to be a general-purpose distribution. It is the system I want to run on my own machine.

- **Based on Wayblue (Sway + Fedora Atomic)**
  - Clean, tiling Wayland desktop using Sway
- **Automatic daily updates**
  - Powered by `ublue-update` and GitHub Actions
- **My personal dotfiles**
  - Cloned into `~/repos/dotfiles` on first login
- **Zsh as default shell**
  - `zsh` is pre-installed and set as the default shell for all users automatically on first boot
- **Distrobox for CLI tools**
  - A distrobox container is available for installing development tools, CLIs, etc. without touching the host
- **Preinstalled applications**
  - Flatpaks: Firefox, Discord, Steam, Spotify, Stremio, Transmission, `org.freedesktop.Platform.codecs-extra`
  - Native RPM tools: `zsh`, `gammastep`

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

- Sets zsh as the default shell for all users
- Clones my dotfiles into `~/repos/dotfiles`
- Installs Flatpaks
- Applies any custom system configs under `system/`

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

To set up a distrobox for development tools:
```bash
distrobox create -n dev
distrobox enter dev
# then install whatever you need: sudo dnf install neovim git etc.
```

## Building

Fork this repo and edit `recipe.yml`. The GitHub Action builds and signs the image automatically.

## License

Upstream projects retain their licenses. Everything else including my dotfiles are MIT unless noted otherwise.
