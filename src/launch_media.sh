#!/bin/bash

# Шляхи до каталогів та файлів
VIDEO_DIR="/home/pharma333/videostream"
AUDIO_DIR="/home/pharma333/audiostream"
LOG_DIR="/home/pharma333/logs"
VIDEO_FILE=$(find "$VIDEO_DIR" -type f -name "*.mp4" | head -n 1)
AUDIO_FILE=$(find "$AUDIO_DIR" -type f -name "*.mp3" | head -n 1)

# Ініціалізація лог-файлу
LOG_FILE="$LOG_DIR/$(date +%F).log"
mkdir -p "$LOG_DIR"
echo "Система ввімкнена: $(date)" >> "$LOG_FILE"

# Запуск відео плейера
if [[ -f "$VIDEO_FILE" ]]; then
    vlc --fullscreen --play-and-exit "$VIDEO_FILE" &
    echo "Відеоплейер запущено з файлом $VIDEO_FILE: $(date)" >> "$LOG_FILE"
else
    echo "Відеофайл не знайдено." >> "$LOG_FILE"
fi

# Запуск аудіо плейера
if [[ -f "$AUDIO_FILE" ]]; then
    vlc --play-and-exit "$AUDIO_FILE" &
    echo "Аудіоплейер запущено з файлом $AUDIO_FILE: $(date)" >> "$LOG_FILE"
else
    echo "Аудіофайл не знайдено." >> "$LOG_FILE"
fi