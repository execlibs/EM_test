#!/bin/sh

# vars/глобальные переменные

PROCESS_NAME="test"
URL="https://test.com/monitoring/test/api"
LOG_FILE="/var/log/monitoring.log"
PID_FILE="/var/log/monitoring.pid"

# check process activity/проверка процесса
if ! pgrep -x "$PROCESS_NAME" > /dev/null; then
    exit 0
fi

# re-create process log/изменение pid у процесса
current_pid=$(pgrep -x "$PROCESS_NAME")
if [ -f "$PID_FILE" ]; then
    old_pid=$(cat "$PID_FILE")
    if [ "$old_pid" != "$current_pid" ]; then
        echo "$(date): Процесс $PROCESS_NAME перезапущен (PID: $old_pid -> $current_pid)" >> "$LOG_FILE"
    fi
fi
echo "$current_pid" > "$PID_FILE"

# check site avalbility (if not see log)/проверка доступности сайта
# curl not avable in my distro
if ! wget -q -O /dev/null --timeout=10 --tries=2 "$URL"; then
    echo "$(date): Сервер мониторинга недоступен" >> "$LOG_FILE"
fi
