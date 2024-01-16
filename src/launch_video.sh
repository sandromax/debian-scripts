#!/bin/bash

VIDEO_DIR="/home/admin30/Dropbox/Pharma/VideoStream"

vlc --fullscreen --loop --no-video-title-show $(find "$VIDEO_DIR" -type f -name "*.mp4" -printf '%p ')
