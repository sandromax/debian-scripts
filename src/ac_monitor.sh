#!/bin/bash

WATCH_DIR="/home/admin30/Dropbox/Pharma/AudioStream"

# Script to restart
SCRIPT="/home/admin30/scripts/la_mplayer.sh"

LOG_FILE="/home/admin30/Dropbox/Pharma/Logs/ac_monitor.log"

# Function to log messages with timestamp
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Monitor the directory for changes
inotifywait -m -e create -e delete -e move -e moved_to -e moved_from "$WATCH_DIR" --format '%f' | while read FILE
do
    if [[ "$FILE" == *.mp3 ]]; then
        log_message "Changes detected in $WATCH_DIR. Restarting $SCRIPT..."

        # Kill all existing instances of the script and mpv before starting a new one
        pkill -f "$SCRIPT"
        pkill -f "mplayer"

        log_message "Terminated all instances of $SCRIPT and mplayer."

        # Start the script
        bash "$SCRIPT" &
        NEW_PID=$!
        log_message "New process $SCRIPT started with PID $NEW_PID."
    fi
done
