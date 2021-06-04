#!/usr/bin/env bash

if [[ $UID -eq 0 ]]; then
  echo "Looks like you are running this script as root"
  echo "Please run this script without root or sudo"
  echo "We will ask for your password when needed"
  exit 1
fi

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! [[ -x "$(command -v zsh)" ]]; then
  if [[ -x "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y git zsh
  else
    sudo dnf upgrade -y
    sudo dnf install -y git zsh
  fi

  chsh -s "$(command -v zsh)"
  curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
fi

for hfile in "$BASEDIR"/{runcom,system}/.[a-z]*; do ln -sfv "$hfile" ~; done

mkdir -p ~/.bin/
ln -sfvd "$BASEDIR"/bin/ ~/.bin/
