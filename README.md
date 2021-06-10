# Dotfiles for WSL

## Disclaimer

This config is fine-tuned for my personal use, but all the paths I use are relative enough for use on any system.

As a precaution, should you want to use my config, create a fork of this repository, review and make any changes that you like, then clone your fork.

## What this script does

This script will install `python 3.9.5` via `pyenv`, `node` and `npm` via `n`, and my flavor of `Oh My Zsh` along with their dependencies.

## How to install this script

- Clone this repository, preferably to your home directory

```bash
cd ~ &&\
git clone https://github.com/Smithienious/dotfiles.git
```

- Move into the directory

```bash
cd ~/dotfiles
```

- Run the script

```bash
. ./install.sh
```

## Credits

Some of these scripts are taken from [pengwin-setup](https://github.com/WhitewaterFoundry/pengwin-setup).

Most of the aliases and functions are stolen from [Oh My Zsh Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins).

## Feedback

Suggestions/improvements are [welcome and encouraged](https://github.com/Smithienious/dotfiles/issues)!
