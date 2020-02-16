hcd() {
    start=${HOME}/$1
    cd $(find "$start" -type d -path '*/\.*' -prune -o -not -name '.*' -type d -print | fzf)
}

up() {
    local qarg="-q $1"
    if [ -z "$1" ] ; then
        qarg=""
    fi

    local start=`pwd`
    local current="$start"
    local ups=( )
    while [ "$current" != "/" ] ; do
        current=$(readlink -f "$current/..")
        ups=( "${ups[@]}" "$current" )
    done
    local choice=$(
        for i in "${ups[@]}" ; do
            echo $i
        done | fzf $qarg
    )
    if [ -z "$choice" ] ; then
        return
    fi
    cd "$choice"
}

down() {
    local qarg="-q $1"
    if [ -z "$1" ] ; then
        qarg=""
    fi

    local choice=$(fd -t d 2> /dev/null | fzf $qarg )
    if [ -z "$choice" ] ; then
        return
    fi
    cd "$choice"
}
