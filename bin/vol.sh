#!/bin/bash

click() {
  paplay click.wav &
}

COMMAND=$1
case $COMMAND in
  up)
    pactl set-sink-volume @DEFAULT_SINK@ '+2500'
    ;;
  down)
    pactl set-sink-volume @DEFAULT_SINK@ '-2500'
    ;;
  mute)
    $(click)
    sleep 0.5
    pactl set-sink-mute @DEFAULT_SINK@ toggle &
    ;;
esac

$(click)
killall -USR1 i3status
