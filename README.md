# ltcSway-os

A personal Fedora Atomic desktop image. Built on [wayblue](https://github.com/wayblueorg/wayblue) (Sway + Fedora Atomic). Designed for daily development work with light gaming on the side.

This image takes the wayblue Sway base and adds my dotfiles, preferred applications, and a few system tweaks. It does not aim to be a general-purpose distribution. It is the system I want to run on my own machine.

## What is included

- **Sway** tiling window manager with wayblue defaults
- **Zsh** as the default shell for all users (set on first boot)
- **Gammastep** for night light / color temperature
- **Distrobox** for development tools and gaming
- **Flatpak applications**: Firefox, Discord, Spotify, Stremio, Transmission, mpv, codecs-extra
- **Signed images** with Sigstore cosign
- **Daily builds** via GitHub Actions

## What is not included

- Firefox RPM (replaced with Flatpak for sandboxing and easier updates)
- Homebrew (use distrobox instead)
- Gamescope, MangoHud, or scheduler tweaks on the host (gaming runs in a distrobox)

## How it works

The image builds from [`recipe.yml`](./recipe.yml) using [BlueBuild](https://blue-build.org/). GitHub Actions builds and signs a new image every day at 06:00 UTC. Systems that run this image update automatically via `ublue-update`.

The base image is `ghcr.io/wayblueorg/sway`. This image layers on top of it.

## First boot

On the first boot after install or rebase:

1. The system sets zsh as the default shell for all users.
2. The system clones my dotfiles into `~/repos/dotfiles`.
3. Flatpak installs the applications listed above.

To apply dotfiles manually:

```bash
cd ~/repos/dotfiles
stow .
```

## Gaming

Steam, MangoHud, and related tools run inside a distrobox container. This keeps the host image small and avoids multilib dependency conflicts.

To create the gaming container:

```bash
distrobox create -n steam --image ghcr.io/ublue-os/toolboxes/steambox:latest
distrobox enter steam
```

Steam, Lutris, MangoHud, vkBasalt, and LatencyFleX are available inside the container out of the box.

## Development tools

For development tools, create a separate distrobox:

```bash
distrobox create -n dev --image ghcr.io/ublue-os/bazzite-arch:latest
distrobox enter dev
sudo dnf install neovim git
```

Distrobox shares your home directory with the host. Files persist across container restarts.

## Building

Fork this repo and edit `recipe.yml`. The GitHub Action builds and signs the image automatically.

## License

Upstream projects retain their licenses. My dotfiles are MIT unless noted otherwise.
