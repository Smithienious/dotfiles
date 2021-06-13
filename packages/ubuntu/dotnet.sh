#!/usr/bin/env bash

source ../common.sh

function main() {
  createtmp

  wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb

  sudo apt update
  sudo apt install -y \
    apt-transport-https \
    dotnet-sdk-5.0 \
    nuget

  cleantmp
  sudo apt autoremove -y
}

main "$@"
