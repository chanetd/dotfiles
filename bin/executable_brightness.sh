#!/bin/sh
current=$(xrandr -q --verbose | grep Brightness | head -n 1 | awk '{ print $2 }')

set_brightness() {
    brightness=$(clamp ${1:-"0.8"})
    outputs=$(xrandr -q | grep '\bconnected\b' | awk '{ print $1 }')
    for output in $outputs ; do
        xrandr --output $output --brightness $brightness
    done
}

increment() {
    inc=${1:-"0.1"}
    new=$(echo "$current + $inc" | bc -l)
    set_brightness $new
}

decrement() {
    dec=${1:-"0.1"}
    new=$(echo "$current - $dec" | bc -l)
    set_brightness $new
}

clamp() {
    echo "if ($1 <= 0.1) 0.1 else if ($1 > 1.0) 1.0 else $1" | bc -l
}

cmd="${1:-get}"
if [ $# -gt 0 ] ; then shift ; fi
case "$cmd" in
    g*)
        echo $current
        ;;
    s*)
        set_brightness $*
        ;;
    i*)
        increment $*
        ;;
    d*)
        decrement $*
        ;;
    *)
        usage
        ;;
esac


