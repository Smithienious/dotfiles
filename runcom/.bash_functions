#!/usr/bin/env bash

# Copy but fancier
function cpv() {
  rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress "$@"
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
  mkdir -p "$@" && cd "$@" || exit
}

# cd then ls
function cl() {
  DIR="$*"
  # if no DIR given, go home
  if [ $# -lt 1 ]; then
    DIR=$HOME
  fi
  builtin cd "${DIR}" &&
    # use your preferred ls command
    ls -lFh
}

# Determine size of a file or total size of a directory
function fs() {
  local arg=-sbh
  if [[ -n "$*" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* -- *
  fi
}

# JSON tools
if [[ $(which "$JSONTOOLS_METHOD") = "" ]]; then
  JSONTOOLS_METHOD=""
fi

if [[ $(which node) != "" && ("x$JSONTOOLS_METHOD" = "x" || "x$JSONTOOLS_METHOD" = "xnode") ]]; then
  alias pp_json='xargs -0 node -e "console.log(JSON.stringify(JSON.parse(process.argv[1]), null, 4));"'
  alias is_json='xargs -0 node -e "try {json = JSON.parse(process.argv[1]);} catch (e) { console.log(false); json = null; } if(json) { console.log(true); }"'
  alias urlencode_json='xargs -0 node -e "console.log(encodeURIComponent(process.argv[1]))"'
  alias urldecode_json='xargs -0 node -e "console.log(decodeURIComponent(process.argv[1]))"'
elif [[ $(which python) != "" && ("x$JSONTOOLS_METHOD" = "x" || "x$JSONTOOLS_METHOD" = "xpython") ]]; then
  alias pp_json='python -c "import sys; del sys.path[0]; import runpy; runpy._run_module_as_main(\"json.tool\")"'
  alias is_json='python -c "
import sys; del sys.path[0];
import json;
try:
	json.loads(sys.stdin.read())
except ValueError, e:
	print False
else:
	print True
sys.exit(0)"'
  alias urlencode_json='python -c "
import sys; del sys.path[0];
import urllib, json;
print urllib.quote_plus(sys.stdin.read())
sys.exit(0)"'
  alias urldecode_json='python -c "
import sys; del sys.path[0];
import urllib, json;
print urllib.unquote_plus(sys.stdin.read())
sys.exit(0)"'
elif [[ $(which ruby) != "" && ("x$JSONTOOLS_METHOD" = "x" || "x$JSONTOOLS_METHOD" = "xruby") ]]; then
  alias pp_json='ruby -e "require \"json\"; require \"yaml\"; puts JSON.parse(STDIN.read).to_yaml"'
  alias is_json='ruby -e "require \"json\"; begin; JSON.parse(STDIN.read); puts true; rescue Exception => e; puts false; end"'
  alias urlencode_json='ruby -e "require \"uri\"; puts URI.escape(STDIN.read)"'
  alias urldecode_json='ruby -e "require \"uri\"; puts URI.unescape(STDIN.read)"'
fi

unset JSONTOOLS_METHOD

# VSCode
VSCODE=code-insiders
if [[ -n "$VSCODE" ]] && ! which $VSCODE &>/dev/null; then
  echo "'$VSCODE' flavour of VS Code not detected."
  unset VSCODE
fi

# Otherwise, try to detect a flavour of VS Code.
if [[ -z "$VSCODE" ]]; then
  if which code &>/dev/null; then
    VSCODE=code
  elif which code-insiders &>/dev/null; then
    VSCODE=code-insiders
  elif which codium &>/dev/null; then
    VSCODE=codium
  else
    return
  fi
fi

alias vsc='$VSCODE .'
alias vsca='$VSCODE --add'
alias vscd='$VSCODE --diff'
alias vscg='$VSCODE --goto'
alias vscn='$VSCODE --new-window'
alias vscr='$VSCODE --reuse-window'
alias vscw='$VSCODE --wait'
alias vscu='$VSCODE --user-data-dir'

alias vsced='$VSCODE --extensions-dir'
alias vscie='$VSCODE --install-extension'
alias vscue='$VSCODE --uninstall-extension'

alias vscv='$VSCODE --verbose'
alias vscl='$VSCODE --log'
alias vscde='$VSCODE --disable-extensions'

# Colored man pages
man() {
  env \
    LESS_TERMCAP_mb="$(printf "\e[31m")" \
    LESS_TERMCAP_md="$(printf "\e[93m")" \
    LESS_TERMCAP_me="$(printf "\e[0m")" \
    LESS_TERMCAP_so="$(printf "\e[1;40;92m")" \
    LESS_TERMCAP_se="$(printf "\e[0m")" \
    LESS_TERMCAP_us="$(printf "\e[36m")" \
    LESS_TERMCAP_ue="$(printf "\e[0m")" \
    man "$@"
}
