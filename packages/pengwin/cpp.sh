#!/usr/bin/env bash

function main {

  pengwin-setup install PROGRAMMING C++

  sudo apt install -y \
    clang \
    clangd \
    lldb \
    lld \
    llvm
}

main "$@"
