#!/usr/bin/env sh
export DISPLAY=:0.0
notify-send -u normal Время "`date +%H:%M` \n$@"
