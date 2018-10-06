# $1 is a path to a wallpaper
if [ "$1" != "" ]
then
    python /home/ekliot/.scripts/colours/colorgen.py $1 > ~/.xterm_colors
    xrdb -merge -I$HOME ~/.Xresources
else
    echo "enter an absolute path to a wallpaper image"
fi
