#!/usr/bin/env bash

function main {

  sudo dnf install -y \
    dotnet-sdk-5.0 \
    nuget
}

main "$@"
