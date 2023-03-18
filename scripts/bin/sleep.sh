#!/bin/bash

#i3lock -c 000000 -e -b -d -I 2 && echo mem | sudo tee /sys/power/state
#i3lock -c 000000 -e -b -d -I 2 && dbus-send --system --print-reply  --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend
i3lock -c 000000 -e -b -d -I 2 && sudo /usr/sbin/pm-suspend
