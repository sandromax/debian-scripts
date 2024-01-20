#!/bin/bash

VIDEO_DIR="/home/admin30/Dropbox/Pharma/VideoStream"

export XDG_RUNTIME_DIR="/run/user/1000"
export DISPLAY=:0

mpv --no-audio --fullscreen --loop-playlist --no-terminal -- "$VIDEO_DIR"/*.mp4

##!/bin/bash
#
## Directory to monitor
#WATCH_DIR="/home/admin30/Dropbox/Pharma/VideoStream"
## Log file
#LOG_FILE="/home/admin30/Dropbox/Pharma/Logs/lvmpv.log"
#
#export XDG_RUNTIME_DIR="/run/user/1000"
#export DISPLAY=:0
#
## Function to log messages with timestamp
#log_message() {
#    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
#}
#
## Function to start mpv
#start_mpv() {
#    mpv --no-audio --fullscreen --loop-playlist --no-terminal -- "$VIDEO_DIR"/*.mp4 &> /dev/null &
#    MPV_PID=$!
#    log_message "MPV started with PID $MPV_PID"
#}
#
## Start mpv and log
#start_mpv
#
## Monitor the directory
#inotifywait -m -e create -e delete -e move -e moved_to -e moved_from "$WATCH_DIR" | while read event
#do
#    log_message "Change detected in directory: $event"
#    if [ -n "$MPV_PID" ]; then
#        kill "$MPV_PID"
#        KILL_EXIT_CODE=$?
#        log_message "Old MPV process (PID $MPV_PID) terminated with exit code $KILL_EXIT_CODE"
#    fi
#    start_mpv
#done
