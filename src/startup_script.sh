#!/bin/bash

LOG_DIR="/home/admin30/Dropbox/Pharma/Logs"
LOG_FILE="$LOG_DIR/$(date +%F).log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

mkdir -p "$LOG_DIR"

log "System start."

log "Dropbox status: "
dropbox status

/home/admin30/scripts/launch_video.sh &
log "Video playback script started."

/home/admin30/scripts/brightness_control.sh &
log "Brightness control script started."

/home/admin30/scripts/launch_audio.sh &
log "Audio playback script started."

/home/admin30/scripts/make_vlc_active.sh &
log "VLC activation script started."

#/home/admin30/scripts/check_and_update_video.sh &
#log "Media update script started."
