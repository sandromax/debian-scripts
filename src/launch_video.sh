#!/bin/bash

#VIDEO_DIR="/home/admin30/Dropbox/Pharma/VideoStream"
#LOG_DIR="/home/admin30/Dropbox/Pharma/Logs"
#LOG_FILE="$LOG_DIR/$(date +%F).log"
#
#log() {
#    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
#}
#
#if pgrep -x "vlc" > /dev/null; then
#    log "Relaunching vidio"
#    pkill -x "vlc"
#fi
#
#vlc --fullscreen --loop --no-video-title-show $(find "$VIDEO_DIR" -type f -name "*.mp4" -printf '%p ')
#
#log
#echo "List of mp4 files in $VIDEO_DIR:" >> "$LOG_FILE"
#find "$VIDEO_DIR" -type f -name "*.mp4" >> "$LOG_FILE"

#!/bin/bash

VIDEO_DIR="/home/admin30/Dropbox/Pharma/VideoStream"

start_vlc() {
    vlc --fullscreen --loop --no-video-title-show $(find "$VIDEO_DIR" -type f -name "*.mp4" -printf '%p ') vlc://quit &
    VLC_PID=$!
}

check_vlc_cpu_usage() {
    if [ -z "$VLC_PID" ] || ! ps -p "$VLC_PID" > /dev/null; then
        echo "VLC is not running. Starting VLC."
        start_vlc
    else
        CPU_USAGE=$(ps -p "$VLC_PID" -o %cpu | tail -n 1 | xargs)
        if [[ $CPU_USAGE == "0.0" ]]; then
            echo "VLC CPU usage is 0. Restarting VLC."
            pkill -x "vlc"
            sleep 5
            start_vlc
        fi
    fi
}

while true; do
    check_vlc_cpu_usage
    sleep 60
done
