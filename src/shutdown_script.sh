#!/bin/bash

LOG_DIR="/home/admin30/Dropbox/Pharma/Logs"
LOG_FILE="$LOG_DIR/$(date +%F).log"

echo "[INFO:] $(date '+%Y-%m-%d %H:%M:%S') System shuts down..." >> "$LOG_FILE"

shutdown now