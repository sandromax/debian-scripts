#!/bin/bash

VIDEO_DIR="/home/admin30/Dropbox/Pharma/VideoStream"

mpv --no-audio --fullscreen --loop-playlist --no-terminal -- "$VIDEO_DIR"/*.mp4
