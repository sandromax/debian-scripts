#!/bin/bash

VIDEO_DIR="/home/admin30/Dropbox/Pharma/VideoStream"
LOG_DIR="/home/admin30/Dropbox/Pharma/Logs"
LOG_FILE="$LOG_DIR/$(date +%F).log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

if pgrep -x "vlc" > /dev/null; then
    log "Relaunching vidio"
    pkill -x "vlc"
fi

vlc --fullscreen --loop --no-video-title-show $(find "$VIDEO_DIR" -type f -name "*.mp4" -printf '%p ')

log
echo "List of mp4 files in $VIDEO_DIR:" >> "$LOG_FILE"
find "$VIDEO_DIR" -type f -name "*.mp4" >> "$LOG_FILE"