#!/usr/bin/env bash

if [[ $UID -eq 0 ]]; then
  echo "Looks like you are running this script as root"
  echo "Please run this script without root or sudo"
  echo "We will ask for your password when needed"
  exit 1
fi

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -z "$(command -v zsh)" || "$1" == "-f" || "$1" == "--force" ]]; then
  basepkg=(git git-lfs htop keychain most nano pinentry-tty rsync tree zsh)

  if [[ -x "$(command -v apt)" ]]; then
    sudo apt update
    sudo apt dist-upgrade -y
    sudo apt install -y "${basepkg[@]}"
    sudo apt install -y \
      apt-utils \
      build-essential \
      curl \
      libbz2-dev \
      libffi-dev \
      liblzma-dev \
      libncursesw5-dev \
      libreadline-dev \
      libsqlite3-dev \
      libssl-dev \
      libxml2-dev \
      libxmlsec1-dev \
      llvm \
      make \
      tk-dev \
      wget \
      xz-utils \
      zlib1g-dev \
      shellcheck
  else
    sudo dnf upgrade -y
    sudo dnf install -y "${basepkg[@]}"
    sudo dnf install -y \
      bzip2 \
      bzip2-devel \
      gcc \
      libffi-devel \
      make \
      openssl-devel \
      readline-devel \
      sqlite \
      sqlite-devel \
      tk-devel \
      xz-devel \
      zlib-devel \
      util-linux-user \
      ShellCheck
  fi

  sudo update-alternatives --set pinentry "$(which pinentry-tty)"

  # Python via pyenv
  curl -SL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"

  pyenv install -s 3.9.5
  pyenv global 3.9.5
  pip install --upgrade pip setuptools wheel

  # Node and npm via n
  curl -SL https://git.io/n-install | bash -s -- -y
  export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

  n rm "$(n --lts)"
  n latest

  chsh -s "$(command -v zsh)"
  curl -SL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash

  # Finalizing configs
  pip install xxh-xxh
  xxh +I xxh-plugin-zsh-ohmyzsh
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
else
  pyenv update
  omz update
fi

for hfile in "$BASEDIR"/{runcom,system}/.[a-z]*; do ln -sfv "$hfile" ~; done

ln -sfv "$BASEDIR"/git/.gitconfig ~
if ! [[ -s ~/.gitignore_global ]]; then
  rsync -ah --info=progress2 "$BASEDIR"/git/.gitignore_global ~
fi
if ! [[ -s ~/.gitconfig_local ]]; then
  rsync -ah --info=progress2 "$BASEDIR"/git/.gitconfig_local ~
  echo '' >~/.gitconfig_local
fi

mkdir -p ~/.bin/
ln -sfvd "$BASEDIR"/bin/ ~/.bin/
exec "$SHELL"
