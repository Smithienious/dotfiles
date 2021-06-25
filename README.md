# Dotfiles for WSL2

## Disclaimer

You should not clone this repo and use directly, instead create a fork or use this repo as a template to create a new one. ([Comparison](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/creating-a-repository-from-a-template#about-repository-templates))

Don't blindly use my config unless you know what that entails.
Review the code, remove things you don’t want or need, and enjoy.

Using the install script will overwrite your configs if the directories are duplicated.

Use at your own risk!

## What this script does

- This script will install `python` via `pyenv`, `node` and `npm` via `n`, and my flavor of `Oh My Zsh` along with their dependencies.

- This script comes bundled with plugins, allowing you to take advantage of functionality of many sorts to your shell.
They are each documented in the README file in their respective `plugins/` folder on the [Oh My Zsh wiki](https://github.com/ohmyzsh/ohmyzsh/wiki).

- This script links `/mnt/wsl/` into your home directory.
This is a folder shared between all the WSL2 machines on your computer.

## How to install this config

- Clone the repository, preferably to your home directory

```bash
cd ~ &&\
git clone https://github.com/Smithienious/dotfiles.git
```

- Move into the directory and run the script

```bash
cd ~/dotfiles
source ./install.sh setup
```

## FAQ

- What is the `wsl` folder in my home directory?

It is a special folder shared between all running WSL2 machines on your PC.
The `wsl` is actually a symbolic link from `/mnt/wsl/`.
Microsoft does not have this folder documented for some reason.

The content of this folder is lost if all machines are off, so use it wisely.

- How do I install a `pip` package in my virtual environment?

The shortcut `va` calls `venv --system-site-packages`, thus preventing local installations of packages already available on the system site.
You can use `--ignore-installed` flag to override this.

```bash
pip install --ignore-installed
```

- Git keeps ignoring my `.vscode` folder

Create a `.gitignore` in your repository an add

```text
!.vscode/
```

## Feedback

Suggestions/improvements are [welcome and encouraged](https://github.com/Smithienious/dotfiles/issues)!

## Credits

Some of these scripts are taken from [pengwin-setup](https://github.com/WhitewaterFoundry/pengwin-setup).

Aliases and functions are shamelessly stolen from [Oh My Zsh Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins).
