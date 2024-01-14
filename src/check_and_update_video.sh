#!/bin/bash

VIDEO_DIR="/home/admin30/Dropbox/Pharma/VideoStream"
LAST_CHECK_FILE="/home/user/scripts/.last_video_check"

# Function for obtaining the time of the last modification of the directory
get_last_mod_time() {
    stat -c "%Y" "$VIDEO_DIR"
}

# Read the time of the last checked update
last_mod_time=$(get_last_mod_time)
if [ -f "$LAST_CHECK_FILE" ]; then
    last_check_time=$(<"$LAST_CHECK_FILE")
else
    last_check_time=0
fi

# Comparison of the time of the last modification and the time of the last check
if [ "$last_mod_time" -ne "$last_check_time" ]; then
    # If the files have been updated, stop the current playback script
    pkill -f launch_video.sh

    # Running the playback script with new files
    /home/user/scripts/launch_video.sh &

    # Saving the new time of the last modification
    echo "$last_mod_time" > "$LAST_CHECK_FILE"
fi
