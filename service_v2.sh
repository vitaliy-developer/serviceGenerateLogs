#!/bin/bash

LOGS_DIR="./logs/"
BACKUP_DIR="./backup/"

# Function to log service status
log_service() {
    if [ ! -d "$LOGS_DIR" ]; then
        mkdir "$LOGS_DIR"
    fi

    DATE=$(date +"%Y-%m-%d_%H-%M-%S")
    PID=$$
    echo "Service with PID $PID is running successfully at $DATE" > "$LOGS_DIR/service_${DATE}.log"
    journalctl | tail -250 >> "$LOGS_DIR/service_${DATE}.log"
}

# Function to create backup
backup_logs() {
    if [ -d "$LOGS_DIR" ]; then
        CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")
        if [ ! -d "$BACKUP_DIR" ]; then
            mkdir "$BACKUP_DIR"
        fi
        7z a "${BACKUP_DIR}backup_${CURRENT_DATE}.7z" "${LOGS_DIR}"*.log
        rm -rf "$LOGS_DIR"/*
    fi
}

# Main loop
while true; do
    log_service
    sleep 10
    backup_logs
    sleep 3
done

# Signal handling for script termination
trap "echo 'Script stopped manually'; exit 0" SIGINT SIGTERM
