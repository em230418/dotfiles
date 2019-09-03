#!/usr/bin/env bash
upower -i /org/freedesktop/UPower/devices/battery_BAT0 > /tmp/battery_state
state=`grep state /tmp/battery_state | awk '{ print $2 }'`
if [ "$state" == "charging" ]; then
    exit 0
fi
perc=`grep percentage /tmp/battery_state | awk '{ print $2 }' | sed 's/[^0-9]*//g'`
if [ "$perc" -lt "10" ]; then
    notify-send -u critical WARNING "Battery low - $perc%"
fi
