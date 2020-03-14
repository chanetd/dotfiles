#!/bin/bash
settings='single
docking
dockingfull
bigscreen
home
dockinghome'

setting=${1:-single}

all="$(xrandr -q)"

get_primary_name() {
    echo "$all" | awk '/^eDP/ { print $1 }' | head -n 1
}
get_secondary_names() {
    echo "$all" | awk '/^D/ { print $1 }' | sort
}

primary=$(get_primary_name)
secondaries=( $(get_secondary_names) )
ext1=${secondaries[0]}
ext2=${secondaries[1]}
ext3=${secondaries[2]}

# the totally useless command below is needed for some reason to kick xrandr into action
xrandr --listmonitors > /dev/null

if [ "$setting" == "select" ] ; then
    setting=$(echo "$settings" | rofi -fuzzy -dmenu -p monitor-mode -i)
fi

case "$setting" in 
    single)
        xrandr --output $primary --auto --scale 1x1 --primary --output $ext1 --off --output $ext2 --off --output $ext3 --off
        ;;
    docking)
        xrandr --output $primary --auto --scale 0.75x0.75 --primary --output $ext1 --auto --right-of $primary --output $ext2 --off --output $ext3 --auto --left-of $primary
        ;;
    dockingfull)
        xrandr --output $primary --auto --primary --output $ext1 --auto --right-of $primary --output $ext2 --off --output $ext3 --auto --left-of $primary
        ;;
    bigscreen)
        xrandr --output $primary --auto --primary --output $ext1 --mode 1920x1080 --auto --output $ext2 --off --output $ext3 --off
        ;;
    home)
        xrandr --output $primary --auto --primary --output $ext1 --mode 2560x1440 --auto --right-of $primary --output $ext2 --off --output $ext3 --off
        ;;
    dockinghome)
        xrandr --output $primary --auto --primary --output $ext1 --off --output $ext2 --off --output $ext3 --mode 2560x1440 --auto --right-of $primary
        ;;
    *)
        echo -e "unknown display mode $setting; known modes are\n$settings" >&2 
esac

numlockx on
