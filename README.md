# ltcSway-os

**ltcSway-os** is my personal, custom Fedora Atomic OS image, built using [uBlue](https://github.com/ublue-os) tools and based on [wayblue](https://github.com/lucastcottle/wayblue-fork) — a minimal, Sway-based desktop environment on Fedora Atomic.

This image includes my preferred tools, dotfiles, and configurations baked in, with automatic updates and reproducible builds via GitHub Actions.


## Features

- **Based on Wayblue (Sway + Fedora Atomic)**
  - Clean, tiling Wayland desktop using Sway
- **Automatic daily updates**
  - Powered by `ublue-update` and GitHub Actions
- **My personal dotfiles**
  - Cloned into `~/repos/dotfiles` on first login
- **Zsh as default shell**
- **Homebrew pre-installed**
  - Pulled in via the `ghcr.io/ublue-os/brew` image at build time
  - On first login, `~/.Brewfile` is auto-bundled to install user tools (`stow`, `neovim`)
  - ublue `brew.just` recipes imported for easy management
- **Preinstalled applications**
  - Flatpaks: Firefox, Discord, Steam, Spotify, Stremio, Transmission, `org.freedesktop.Platform.codecs-extra`
  - Native RPM tools: `zsh`, `gammastep`


## How It Works

- **Image source**: [`recipe.yml`](./recipe.yml)
- **Base image**: [`ghcr.io/wayblueorg/sway`](https://github.com/lucastcottle/wayblue-fork)
- **Builds**: GitHub Actions builds and signs new image versions daily (6:00 UTC)
- **Auto-updates**: Systems running this image will check for new versions and auto-rebase using `ublue-update`



## First Boot Behavior

- Clones my dotfiles into `~/repos/dotfiles`
- Sets default shell to `zsh` for new users
- Installs Flatpaks
- Runs `brew bundle --file=~/.Brewfile` on first login to install user tools
- Applies any custom system configs under `system/`


## Manual Setup (Optional)

If you need to re-stow or manually apply dotfiles:
```bash
cd ~/repos/dotfiles
stow .
```

To manually run the Homebrew bundle:
```bash
brew bundle --file=~/.Brewfile
```

## Building It Yourself

This image is built via the blue-build GitHub Action. You can fork this repo and customize your own image by editing recipe.yml.

## Security

This image is signed using Sigstore and includes policies for secure OSTree updates.

## License

This repo follows the licensing of the included upstream projects. My dotfiles are MIT licensed unless otherwise noted. 
