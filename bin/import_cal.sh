#!/bin/bash

CALENDAR=$(echo Personal Work| dmenu -p "Add to:" -lines 20 -sep ' ')

gcalcli --calendar="$CALENDAR" import -v "$1"

notify-send "Added event to $CALENDAR"
