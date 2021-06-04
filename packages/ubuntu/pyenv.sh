#!/usr/bin/env bash

function main {

  sudo apt install -y \
    build-essential \
    curl \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncurses5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    llvm \
    tk-dev \
    xz-utils \
    wget \
    zlib1g-dev

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
