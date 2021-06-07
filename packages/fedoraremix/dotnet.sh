#!/usr/bin/env bash

function main() {
  sudo dnf upgrade -y
  sudo dnf install -y \
    dotnet-sdk-5.0 \
    nuget
  sudo dnf autoremove -y
}

main "$@"
