#!/usr/bin/env bash

if [[ $UID -eq 0 ]]; then
  echo "Looks like you are running this script as root"
  echo "Please run this script without root or sudo"
  echo "We will ask for your password when needed"
  exit 1
fi

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function update_upgrade {
  if [[ -x "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt full-upgrade -y
    sudo apt autoremove -y
  elif [[ -x "$(command -v dnf)" ]]; then
    sudo dnf upgrade -y
    sudo dnf autoremove -y
  fi
}

function base_packages {
  basepkgs=(curl dos2unix git git-lfs htop keychain less make most nano
    openssl pinentry-tty rsync tree)

  if [[ -x "$(command -v apt)" ]]; then
    sudo apt install -y "${basepkgs[@]}" shellcheck
  elif [[ -x "$(command -v dnf)" ]]; then
    sudo dnf install -y "${basepkgs[@]}" ShellCheck
  fi

  sudo update-alternatives --set pinentry "$(command -v pinentry-tty)"
}

function node_n {
  curl -SL https://git.io/n-install | bash -s -- -y
  export N_PREFIX="$HOME/n"
  [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

  n rm "$(n --lts)"
  n latest
}

function python_pyenv {
  ubuntu=(apt-utils build-essential curl libbz2-dev libffi-dev liblzma-dev
    libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev
    libxmlsec1-dev llvm make tk-dev wget xz-utils zlib1g-dev)
  fedora=(bzip2 bzip2-devel gcc libffi-devel make openssl-devel readline-devel
    sqlite sqlite-devel tk-devel xz-devel zlib-devel util-linux-user)

  if [[ -x "$(command -v apt)" ]]; then
    sudo apt install -y "${ubuntu[@]}"
  elif [[ -x "$(command -v dnf)" ]]; then
    sudo dnf install -y "${fedora[@]}"
  fi

  curl -SL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"

  pyenv install -s 3.9.5
  pyenv global 3.9.5
  pip install --upgrade pip setuptools wheel
  pip install pipupgrade pygments
}

function omz_zsh {
  if [[ -x "$(command -v apt)" ]]; then
    sudo apt install -y zsh
  elif [[ -x "$(command -v dnf)" ]]; then
    sudo dnf install -y zsh
  fi

  chsh -s "$(command -v zsh)"
  curl -SL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash

  pip install xxh-xxh
  xxh +I xxh-plugin-zsh-ohmyzsh
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
}

function link_dotfiles {
  for DOTFILE in "$BASEDIR"/{git,system}/.[a-z]*; do ln -sfv "$DOTFILE" ~; done
  for DOTFILE in "$BASEDIR"/runcom/{ba,z}sh/.[a-z]*; do ln -sfv "$DOTFILE" ~; done

  ln -sfvd "$BASEDIR"/system/.bin/ ~
  ln -sfvd /mnt/wsl/ ~
}

# https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html
while [[ $# -gt 0 ]]; do
  case "$1" in
  install | autoinstall)
    update_upgrade
    base_packages
    python_pyenv
    omz_zsh
    node_n
    link_dotfiles
    shift
    ;;
  update | upgrade)
    git pull --rebase --autostash
    update_upgrade
    pyenv update
    omz update
    n-update -y
    shift
    ;;
  git | pull)
    git pull --rebase --autostash
    ;;
  dotfile | dotfiles)
    link_dotfiles
    shift
    ;;
  *)
    shift
    ;;
  esac
done

command clear
