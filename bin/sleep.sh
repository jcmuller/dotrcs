#!/bin/bash

i3lock -c 000000 -e -b -d -I 2 && echo mem | sudo tee /sys/power/state
