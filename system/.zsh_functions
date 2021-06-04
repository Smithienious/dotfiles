#!/usr/bin/env bash

# `vs` with no arguments opens the current directory in VSCode, otherwise opens the given location
function vs() {
	if [ $# -eq 0 ]; then
		code .
	else
		code "$@"
	fi
}

# `vsi` with no arguments opens the current directory in VSCode Insiders, otherwise opens the given location
function vsi() {
	if [ $# -eq 0 ]; then
		code-insiders .
	else
		code-insiders "$@"
	fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX
}

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$@"
}

# cd then ls
function cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
        ls -hlsG --color=tty --group-directories-first --time-style=long-iso
}

# Determine size of a file or total size of a directory
function fs() {
	local arg=-sbh
	if [[ -n "$@" ]]; then
		du $arg -- "$@"
	else
		du $arg .[^.]* *
	fi
}

# Colored man pages
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[31m") \
		LESS_TERMCAP_md=$(printf "\e[93m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;40;92m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[36m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		man "$@"
}
