#!/bin/bash

pkill -f start.sh

LOGS_DIR="./logs/"
# LOGS_DIR="$HOME/serviceGenerateLogs/logs/" # full path to crontab

if [ -d "$LOGS_DIR" ]; then
    CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")
    
    7z a "backup_${CURRENT_DATE}.7z" "$LOGS_DIR"*.log
    
    mv "backup_${CURRENT_DATE}.7z" "backup/"
    # mv "backup_${CURRENT_DATE}.7z" "$HOME/serviceGenerateLogs/backup/" # full path to crontab
    rm -rf "$LOGS_DIR"/*
fi
