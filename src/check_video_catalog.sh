#!/bin/bash

# Шлях до каталогу, який потрібно моніторити
WATCH_DIR="/home/admin30/Dropbox/Pharma/VideoStream"

# Шлях до скрипта, який необхідно перезапустити
LAUNCH_SCRIPT="/home/admin30/scripts/launch_video.sh"

# Функція для перезапуску скрипта
restart_script() {
    # Знаходимо і зупиняємо попередній процес, якщо він виконується
    pkill -f "$LAUNCH_SCRIPT"

    # Запускаємо скрипт знову
    "$LAUNCH_SCRIPT" &
}

# Головний цикл
while true; do
    # Чекаємо на зміни у вказаному каталозі
    inotifywait -e modify -e move -e create -e delete "$WATCH_DIR"

    # Перезапускаємо скрипт у відповідь на зміни
    restart_script
done
