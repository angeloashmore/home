export PATH=~/bin:~/.local/bin:~/.npm-global/bin:/opt/homebrew/bin:$PATH
export EDITOR=nvim

autoload -U colors && colors
PROMPT="%F{black}──%F{reset_color} "
RPROMPT='%F{black}%2d'

set -s set-clipboard on

# docs.pkgx.sh
# eval "$(pkgx --quiet dev --shellcode)"

# mise.jdx.dev
eval "$(~/.local/bin/mise activate zsh)"

# source antidote
source $ZDOTDIR/.antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#         exec tmux new-session -A -s "main"
# fi
