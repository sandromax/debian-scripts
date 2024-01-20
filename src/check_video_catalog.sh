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
#---
#!/bin/bash

# Directory to monitor
WATCH_DIR="/home/admin30/Dropbox/Pharma/VideoStream"

# Script to restart
SCRIPT="/home/admin30/scripts/lvmpv.sh"

# Log file
LOG_FILE="/home/admin30/Dropbox/Pharma/Logs/lvmpv.log"

# Function to log messages with date and time
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Monitoring the directory for creation or deletion of MP4 files
inotifywait -m -e create -e delete "$WATCH_DIR" --format '%f' | while read FILE
do
    if [[ "$FILE" == *.mp4 ]]; then
        log_message "Changes detected in $WATCH_DIR. Restarting $SCRIPT..."

        # Find the PID of the old script and MPV process
        OLD_SCRIPT_PID=$(pgrep -f "$SCRIPT")
        OLD_MPV_PID=$(pgrep -f "mpv")

        # Start the new script
        bash "$SCRIPT" &
        log_message "New process $SCRIPT started."

        # Delay before killing the old processes
        sleep 5

        # Terminating old processes
        if [[ -n "$OLD_SCRIPT_PID" ]]; then
            kill "$OLD_SCRIPT_PID"
            log_message "Terminated old process $SCRIPT with PID $OLD_SCRIPT_PID."
        fi

        if [[ -n "$OLD_MPV_PID" ]]; then
            kill "$OLD_MPV_PID"
            log_message "Terminated MPV process with PID $OLD_MPV_PID."
        fi
    fi
done


