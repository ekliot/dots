#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

$HOME/.monicarc   #monitor calibration

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

urxvtd &
unclutter &

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# xmodmap ~/.capswap &
# mpd &

redshift -l 38.8951100:-77.0363700 &

i3_out="$(date '+%Y-%m-%d_%H%M%S')"
exec i3 -V &> ~/.log/i3/i3log_$i3_out
