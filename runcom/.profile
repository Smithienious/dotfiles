# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.bin" ]; then
  PATH="$HOME/.bin:$PATH"
fi

# User configuration
export GPG_TTY=$(tty)
echo "Did you know that:"
whatis $(ls /bin | shuf -n 1)
# eval "$(keychain --eval --agents ssh,gpg <ssh> <gpg>)"
