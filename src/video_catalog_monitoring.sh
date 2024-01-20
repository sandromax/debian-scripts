#!/bin/bash

# Directory to monitor
WATCH_DIR="/home/admin30/Dropbox/Pharma/VideoStream"

# Script to restart
SCRIPT="/home/admin30/scripts/lvmpv.sh"

LOG_FILE="/home/admin30/Dropbox/Pharma/Logs/vc_monitor.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

inotifywait -m -e create -e delete -e move -e moved_to -e moved_from "$WATCH_DIR" --format '%f' | while read FILE
do
    if [[ "$FILE" == *.mp4 ]]; then
        log_message "Changes detected in $WATCH_DIR. Restarting $SCRIPT..."

        OLD_SCRIPT_PID=$(pgrep -f "$SCRIPT")
        OLD_MPV_PID=$(pgrep -f "mpv")

        bash "$SCRIPT" &
        log_message "New process $SCRIPT started."

        sleep 5

        if [[ -n "$OLD_SCRIPT_PID" ]]; then
            kill "$OLD_SCRIPT_PID"
            log_message "Terminated old process $SCRIPT with PID $OLD_SCRIPT_PID."
        fi

        if [[ -n "$OLD_MPV_PID" ]]; then
            kill "$OLD_MPV_PID"
            log_message "Terminated MPV process with PID $OLD_MPV_PID."
        fi
    fi
done
