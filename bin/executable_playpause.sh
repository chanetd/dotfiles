#!/bin/bash
candidates=$(playerctl -a metadata --format '{{playerName}} {{lc(status)}}' | grep -E 'playing|paused' | awk '{print $1}')
numplayers=$(echo "$candidates" | wc -l)
case $numplayers in
    0)
        exit
        ;;
    1)
        player=$candidates
        ;;
    *)
        player=$(echo "$candidates" | rofi -fuzzy -dmenu -p "Select player" -i)
        ;;
esac
playerctl --player "$player" play-pause
