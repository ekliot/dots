#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# KILL THE BEEPS
xset b off

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# list all the colors
# for C in {0..255}; do tput setab $C && echo -n "$C "; done; tput sgr0; echo

# CUSTOM PROMPT
bold="\[$(tput bold)\]"
orange="\[$(tput setaf 2)\]"
blue="\[$(tput setaf 5)\]"
white="\[$(tput setaf 7)\]"
reset="\[$(tput sgr0)\]"
export PS1="${bold}${white}[\A ${orange}\u${white}@${blue}\h${white}:${blue}\W${white}]${reset} \$> "

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export EDITOR=vim

if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P0222222
  \e]P1e84f4f
  \e]P2b7ce42
  \e]P3fea63c
  \e]P466aabb
  \e]P5b7416e
  \e]P66d878d
  \e]P7dddddd
  \e]P8666666
  \e]P9d23d3d
  \e]PAbde077
  \e]PBffe863
  \e]PCaaccbb
  \e]PDe16a98
  \e]PE42717b
  \e]PFcccccc
  "
  # get rid of artifacts
  clear
fi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

color_prompt=yes

source ~/.rvm/scripts/rvm

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

eval $(keychain --eval --quiet id_rsa)
