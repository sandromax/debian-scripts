#!/bin/bash

AUDIO_DIR="/home/admin30/Dropbox/Pharma/AudioStream"

find "$AUDIO_DIR" -name "*.mp3" -exec mplayer -vo null -quiet {} \; &
