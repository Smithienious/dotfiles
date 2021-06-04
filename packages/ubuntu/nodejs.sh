#!/usr/bin/env bash

function main {

  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update
  sudo apt install -y build-essential yarn

  # Installing n, Node.js version manager
  curl -fsSL https://git.io/n-install | bash -s -- -y

  N_PATH="$(grep <"$HOME"/.bashrc "^.*N_PREFIX.*$" | cut -d'#' -f 1)"
  echo "${N_PATH}" | sudo tee "${NPM_PROFILE}"
  eval "${N_PATH}"

  # Clear N from .bashrc now not needed
  filecontents=$(grep <"$HOME"/.bashrc -v -e '^.*N_PREFIX.*$')
  printf '%s' "$filecontents" >"$HOME/.bashrc"

  # Add the path for sudo
  SUDO_PATH="$(sudo cat /etc/sudoers | grep "secure_path" | sed "s/\(^.*secure_path=\"\)\(.*\)\(\"\)/\2/")"
  echo "Defaults secure_path=\"${SUDO_PATH}:${N_PREFIX}/bin\"" | sudo EDITOR='tee ' visudo --quiet --file=/etc/sudoers.d/npm-path

  # Install latest node.js release
  n latest

  # Install npm
  curl -fsSL https://npmjs.com/install.sh | bash

  # Add npm to bash completion
  sudo mkdir -p /etc/bash_completion.d
  npm completion | sudo tee /etc/bash_completion.d/npm
}

main "$@"
