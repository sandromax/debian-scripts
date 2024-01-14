#!/bin/bash

HOUR=$(date +%H)

if [ "$HOUR" -ge 8 ] && [ "$HOUR" -lt 10 ]; then
    xrandr --output <YourMonitor> --brightness 0.3
elif [ "$HOUR" -ge 10 ] && [ "$HOUR" -lt 17 ]; then
    xrandr --output <YourMonitor> --brightness 0.8
elif [ "$HOUR" -ge 17 ] && [ "$HOUR" -lt 20 ]; then
    xrandr --output <YourMonitor> --brightness 0.3
fi