export PATH=~/bin:~/.local/bin:~/.npm-global/bin:/opt/homebrew/bin:$PATH
export EDITOR=nvim

autoload -U colors && colors
PROMPT="%F{black}──%F{reset_color} "
RPROMPT='%F{black}%2d'

set -s set-clipboard on

# mise.jdx.dev
eval "$(~/.local/bin/mise activate zsh)"

# antidote
source $ZDOTDIR/.antidote/antidote.zsh
antidote load

