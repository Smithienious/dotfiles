#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y \
  apt-utils \
  gcc \
  git-lfs \
  htop \
  keychain \
  nano \
  shellcheck \
  tree

# shellcheck source=cpp.sh
. ./cpp.sh
# shellcheck source=dotnet.sh
. ./dotnet.sh

sudo apt autoremove -y --purge
