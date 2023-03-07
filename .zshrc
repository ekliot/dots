[[ $- != *i* ]] && return

# --- HISTORY
# ===========

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
HISTCONTROL=ignoredups:ignorespace

# --- ZSH
# =======

setopt autocd extendedglob 
setopt COMPLETE_ALIASES # autocomplete for aliases
unsetopt beep

zstyle :compinstall filename '/home/ekliot/.zshrc'
# use arrow keys in tab completion
zstyle ':completion:*' menu select

autoload -Uz compinit promptinit
compinit
promptinit

# rehash autocompletion on SIGUSR1
# refer to /etc/pacman.d/hooks/zsh.hook
TRAPUSR1() { rehash }

# --- KEYBINDS
# ============

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"          ]] && bindkey -- "${key[Home]}"           beginning-of-line
[[ -n "${key[End]}"           ]] && bindkey -- "${key[End]}"            end-of-line
[[ -n "${key[Insert]}"        ]] && bindkey -- "${key[Insert]}"         overwrite-mode
[[ -n "${key[Backspace]}"     ]] && bindkey -- "${key[Backspace]}"      backward-delete-char
[[ -n "${key[Delete]}"        ]] && bindkey -- "${key[Delete]}"         delete-char
#[[ -n "${key[Up]}"            ]] && bindkey -- "${key[Up]}"           up-line-or-history
#[[ -n "${key[Down]}"          ]] && bindkey -- "${key[Down]}"         down-line-or-history
[[ -n "${key[Up]}"            ]] && bindkey -- "${key[Up]}"             up-line-or-beginning-search
[[ -n "${key[Down]}"          ]] && bindkey -- "${key[Down]}"           down-line-or-beginning-search
[[ -n "${key[Left]}"          ]] && bindkey -- "${key[Left]}"           backward-char
[[ -n "${key[Right]}"         ]] && bindkey -- "${key[Right]}"          forward-char
[[ -n "${key[PageUp]}"        ]] && bindkey -- "${key[PageUp]}"         beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"      ]] && bindkey -- "${key[PageDown]}"       end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}"     ]] && bindkey -- "${key[Shift-Tab]}"      reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"   backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}"  forward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  function zle_application_mode_start { echoti smkx }
  function zle_application_mode_stop { echoti rmkx }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


# --- PROMPT
# ==========

zstyle :prompt:pure:git:stash show yes

prompt pure

RPS1="%B<%*>%b" 

# hack to remove newline before prompt
# https://github.com/sindresorhus/pure/issues/509#issuecomment-641001784
print() {
  [ 0 -eq $# -a "prompt_pure_precmd" = "${funcstack[-1]}" ] || builtin print "$@";
}

# --- ALIAS
# =========

alias ls='ls --color=auto'
alias ll='ls -l --group-directories-first'
alias rm='trash'
alias cp='cp -v'
alias mv='mv -v'

# ---

# eval $(keychain --eval --quiet id_rsa)
