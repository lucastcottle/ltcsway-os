#!/usr/bin/env bash

set -oue pipefail

# Set zsh as the default shell for new users
sed -i 's|^SHELL=.*|SHELL=/usr/bin/zsh|' /etc/default/useradd

# Install a one-shot systemd service to set zsh for existing users on first boot
cat > /etc/systemd/system/set-zsh-default.service << 'UNIT'
[Unit]
Description=Set zsh as default shell for existing users
After=multi-user.target
ConditionPathExists=!/etc/.zsh-default-set

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'for user in $(getent passwd | awk -F: "$3 >= 1000 && $3 < 65534 {print $1}"); do chsh -s /usr/bin/zsh "$user" 2>/dev/null; done && touch /etc/.zsh-default-set'
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
UNIT

chmod 644 /etc/systemd/system/set-zsh-default.service
