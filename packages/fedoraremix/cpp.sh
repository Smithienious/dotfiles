#!/usr/bin/env bash

function main {

  sudo dnf install -y \
    clang \
    gcc \
    gdb \
    gdb-gdbserver \
    g++ \
    lldb \
    lld \
    make \
    rsync \
    zip

  # Install the Microsoft version of CMake for Visual Studio
  local dist
  dist="$(uname -m)"
  if [[ ${dist} == "x86_64" ]]; then
    wget "https://github.com/microsoft/CMake/releases/download/v3.19.4268486/cmake-3.19.4268486-MSVC_2-Linux-${dist/86_/}.sh" -O cmake.sh
    sudo bash cmake.sh --skip-license --prefix=/usr/local
    rm cmake.sh
  fi
}

main "$@"
