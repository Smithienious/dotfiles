#!/usr/bin/env bash

function main {

  pengwin-setup install PROGRAMMING PYTHONPI PYENV

  pyenv install -s 3.9.5
  pyenv global 3.9.5
  pip install --upgrade pip setuptools wheel
}

main "$@"
