#!/bin/bash

# Directory to monitor
WATCH_DIR="/home/admin30/Dropbox/Pharma/VideoStream"

# Script to restart
SCRIPT="/home/admin30/scripts/lvmpv.sh"

LOG_FILE="/home/admin30/Dropbox/Pharma/Logs/vc_monitor.log"

# Function to log messages with timestamp
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Monitor the directory for changes
inotifywait -m -e create -e delete -e move -e moved_to -e moved_from "$WATCH_DIR" --format '%f' | while read FILE
do
    if [[ "$FILE" == *.mp4 ]]; then
        log_message "Changes detected in $WATCH_DIR. Restarting $SCRIPT..."

        # Kill all existing instances of the script and mpv before starting a new one
        pkill -f "$SCRIPT"
        pkill -f "mpv"

        log_message "Terminated all instances of $SCRIPT and mpv."

        # Start the script
        bash "$SCRIPT" &
        NEW_PID=$!
        log_message "New process $SCRIPT started with PID $NEW_PID."
    fi
done
