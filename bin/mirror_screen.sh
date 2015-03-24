#!/bin/bash

xrandr \
  --output eDP1 --auto \
  --output DP1 --auto --same-as eDP1 \
  --output HDMI1 --auto --same-as eDP1
