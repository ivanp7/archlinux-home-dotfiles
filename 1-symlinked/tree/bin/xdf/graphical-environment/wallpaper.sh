#!/bin/sh

# kill animated wallpaper, if it is displayed
pkill xwinwrap

FILE=$1
MODE=$2
START=$3

if [ -z "$FILE" ]
then exit 1
fi

set_classic_wallpaper ()
{
    feh --no-fehbg --bg-scale "$1" 
}

start_animated_wallpaper ()
{
    if [ -z "$2" ]
    then RAND=$(shuf -i 0-99 -n 1)
    else RAND=$(($2 % 100))
    fi
    MPV_OPTIONS="--osc=no --osd-level=0 --no-input-default-bindings --vo=gpu --hwdec=auto --loop=inf --start=$RAND%"

    # dependency: shantz-xwinwrap-bzr from AUR
    if [ -f "$1" ]
    then exec xwinwrap -ov -fs -- mpv -wid WID $MPV_OPTIONS "$1" > /dev/null 2>&1 &
    fi
}

if [ -z "$MODE" ]
then
    mime_type=$(file --mime-type "$FILE" -bLE) || mime_type=""
    case $mime_type in
        video/*) start_animated_wallpaper "$FILE" $START ;;
        image/*) set_classic_wallpaper "$FILE" ;;
        *) exit 1 ;;
    esac
else
    case "$MODE" in
        animated) start_animated_wallpaper "$FILE" $START ;;
        classic) set_classic_wallpaper "$FILE" ;;
        *) exit 1 ;;
    esac
fi

