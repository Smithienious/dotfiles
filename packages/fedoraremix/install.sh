#!/usr/bin/env bash

sudo dnf upgrade -y
sudo dnf install -y \
  gcc \
  git-lfs \
  htop \
  keychain \
  nano \
  pinentry \
  ShellCheck \
  tree \
  util-linux-user

# shellcheck source=cpp.sh
. ./cpp.sh
# shellcheck source=dotnet.sh
. ./dotnet.sh
# shellcheck source=nodejs.sh
. ./nodejs.sh

sudo dnf autoremove -y
