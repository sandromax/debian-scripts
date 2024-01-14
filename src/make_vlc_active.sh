#!/bin/bash

while true; do
  # Searching VLC window ID
  VLC_WINDOW_ID=$(wmctrl -l | grep VLC | awk '{print $1}')

  # If a window is found, make it active
  if [ ! -z "$VLC_WINDOW_ID" ]; then
    wmctrl -i -a "$VLC_WINDOW_ID"
  fi

  # Wait 60 seconds before next iteration
  sleep 60
done