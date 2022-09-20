#!/bin/bash

click() {
  pactl play-sample audio-volume-change @DEFAULT_SINK@ &
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
  mic-mute)
    $(click)
    sleep 0.5
    pactl set-source-mute @DEFAULT_SINK@ toggle &
    ;;
esac

$(click)
