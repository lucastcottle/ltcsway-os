#!/usr/bin/env bash

set -oue pipefail

# Install brew bundle on first login if Brewfile exists
cat > /etc/profile.d/brew-bundle.sh << 'PROFILE'
# One-time brew bundle install on first login
if [ -f /usr/share/brew/Brewfile ] && [ ! -f ~/.brew-bundle-done ]; then
    brew bundle --file=/usr/share/brew/Brewfile && touch ~/.brew-bundle-done
fi
PROFILE

chmod 644 /etc/profile.d/brew-bundle.sh
