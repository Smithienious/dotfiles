#!/usr/bin/env bash

function main {

  sudo dnf install -y \
    bzip2 \
    bzip2-devel \
    findutils \
    libffi-devel \
    openssl-devel \
    readline-devel \
    sqlite \
    sqlite-devel \
    xz \
    xz-devel \
    zlib-devel

  curl -fsSL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"

  pyenv install -s 3.9.5
  pyenv global 3.9.5
  pip install --upgrade pip setuptools wheel
}

main "$@"
