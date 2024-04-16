#!/bin/bash

LOGS_DIR="./logs/"
# LOGS_DIR="$HOME/serviceGenerateLogs/logs/" # full path to crontab

if [ ! -d "$LOGS_DIR" ]; then
    mkdir "$LOGS_DIR"
fi

while true; do
    DATE=$(date +"%Y-%m-%d_%H-%M-%S")
    PID=$$
    echo "Service with PID $PID is running successfully at $DATE" > "$LOGS_DIR/service_${DATE}.log"
    journalctl | tail -250 >> "$LOGS_DIR/service_${DATE}.log"
    sleep 10
done
