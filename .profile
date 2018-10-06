# = = = = = = #
# PATH stuffs #
# = = = = = = #

export PATH="$PATH:$HOME/.local/bin"

# add npm global files to PATH
export PATH=~/.npm-global/bin:$PATH

# add gems to PATH
PATH=$PATH:$(ruby -r rubygems -e "puts Gem.user_dir")/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# = = = = #
# start X #
# = = = = #

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
