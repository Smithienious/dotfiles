# Dotfiles for WSL2

## Disclaimer

If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails.
Use at your own risk!

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

- Move into the directory and run the script

```bash
cd ~/dotfiles
source ./install.sh install
```

## FAQ

- What is the `wsl` folder in my home directory?

It is a special folder shared between all running WSL2 machines on your PC.
The `wsl` is actually a symbolic link from `/mnt/wsl/`.
Microsoft does not have this documented for some reason.

The content of this folder is lost if all machines are off, so use it wisely.

- How do I install a pip package in my virtual environment?

The shortcut `va` calls `venv --system-site-packages`, thus preventing local installations of packages already available on the system site.
You can use `--ignore-installed` flag to override this.

```bash
pip install --ignore-installed
```

## Feedback

Suggestions/improvements are [welcome and encouraged](https://github.com/Smithienious/dotfiles/issues)!

## Credits

Some of these scripts are taken from [pengwin-setup](https://github.com/WhitewaterFoundry/pengwin-setup).

Aliases and functions are shamelessly stolen from [Oh My Zsh Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins).
