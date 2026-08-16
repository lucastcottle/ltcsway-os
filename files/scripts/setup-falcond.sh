#!/usr/bin/env bash

set -oue pipefail

# Create falcond group and add default user
groupadd -f falcond
usermod -a -G falcond lucas
