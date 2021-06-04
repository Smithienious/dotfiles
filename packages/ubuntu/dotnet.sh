#!/usr/bin/env bash

function main {

  dist="$(uname -m)"
  if [[ ${dist} != "x86_64" ]]; then
    echo "Skipping DOTNET not supported in ARM64"
    exit 0
  fi
  unset dist

  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
  sudo cp microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
  rm microsoft.gpg

  echo 'deb https://packages.microsoft.com/repos/microsoft-debian-buster-prod buster main' | sudo tee /etc/apt/sources.list.d/microsoft.list

  sudo apt update
  sudo apt install -y \
    dotnet-sdk-5.0 \
    nuget
}

main "$@"
