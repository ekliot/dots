#
# ~/.zshenv
#

export EDITOR=nvim

typeset -U PATH path
# put path additions between ~/.local/bin and [@]
path=("$HOME/.local/bin" "$path[@]")
export PATH

fpath+=$HOME/.zsh/pure

export TERM_ITALICS=true
