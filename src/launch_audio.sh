#!/bin/bash

AUDIO_DIR="/home/admin30/Dropbox/Pharma/AudioStream"

LOG_DIR="/home/admin30/Dropbox/Pharma/Logs"
LOG_FILE="$LOG_DIR/$(date +%F).log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

if pgrep -x "mplayer" > /dev/null; then
    log "Relaunching audio"
    pkill -x "mplayer"
fi

while true; do
    mplayer -novideo -really-quiet -playlist <(find "$AUDIO_DIR" -type f -name "*.mp3" -print)
    log
    echo "List of mp3 files in $AUDIO_DIR:" >> "$LOG_FILE"
    find "$AUDIO_DIR" -type f -name "*.mp3" >> "$LOG_FILE"
done
