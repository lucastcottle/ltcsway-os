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
- **Gaming stack**
  - Steam, Gamescope, and MangoHud run in a distrobox container based on [bazzite-arch](https://github.com/ublue-os/bazzite-arch)
  - `scx_lavd` scheduler (BPF-based, latency-aware) loaded at boot via `scx_loader` for better frame pacing and input latency
- **Preinstalled applications**
  - Flatpaks: Firefox, Discord, Spotify, Stremio, Transmission, Chromium, mpv, ProtonUp-Qt, `org.freedesktop.Platform.codecs-extra`
  - Native RPM tools: `zsh`, `gammastep`, `gamescope`, `mangohud`

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
| Distrobox | Development tools and gaming | `neovim`, `git`, Steam, etc. |

### First boot behavior

- Sets zsh as the default shell for all users
- Clones my dotfiles into `~/repos/dotfiles`
- Installs Flatpaks
- Applies any custom system configs under `system/`

For development tools, create a distrobox:
```bash
distrobox create -n dev --image ghcr.io/ublue-os/bazzite-arch:latest
distrobox enter dev
sudo dnf install neovim git
```
Steam, MangoHud, and other gaming tools are available inside this container out of the box.

### Gaming

| Component | Source | Purpose |
|---|---|---|
| scx-scheds | CachyOS COPR (`bieszczaders/kernel-cachyos-addons`) | Provides `scx_lavd`, the default system scheduler |
| Steam, MangoHud | bazzite-arch distrobox | Gaming platform and performance overlay |

scx_lavd runs as a systemd service on boot via `scx_loader`. It is a latency-aware scheduler designed for gaming and interactive workloads. The scheduler is configured in `/etc/scx_loader/config.toml`.

## Building

Fork this repo and edit `recipe.yml`. The GitHub Action builds and signs the image automatically.

## License

Upstream projects retain their licenses. Everything else including my dotfiles are MIT unless noted otherwise.
