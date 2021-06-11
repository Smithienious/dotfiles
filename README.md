# Dotfiles for WSL2

## Disclaimer

This config is fine-tuned for my personal use, but all the paths I use are relative enough for use on any system.

As a precaution, should you want to use my config, create a fork of this repository, review and make any changes that you like, then clone your fork.

## What this script does

- This script will install `python 3.9.5` via `pyenv`, `node` and `npm` via `n`, and my flavor of `Oh My Zsh` along with their dependencies.

- This script comes bundled with plugins, allowing you to take advantage of functionality of many sorts to your shell. They are each documented in the README file in their respective `plugins/` folder on the [Oh My Zsh wiki](https://github.com/ohmyzsh/ohmyzsh/wiki).

- This script links `/mnt/wsl/` into your home directory. This is a folder shared between all the WSL2 machines on your computer.

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

Aliases and functions are shamelessly stolen from [Oh My Zsh Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins).

## Feedback

Suggestions/improvements are [welcome and encouraged](https://github.com/Smithienious/dotfiles/issues)!
