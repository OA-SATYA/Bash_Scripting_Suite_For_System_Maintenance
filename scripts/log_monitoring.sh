#!/bin/bash
set -e  # Stop if any real error happens

BASE_DIR="$HOME/bash_maintenance_suite"
LOG_DIR="$BASE_DIR/logs"
LOG_FILE="$LOG_DIR/monitor.log"
ALERT_FILE="$LOG_DIR/alerts.txt"
SYSTEM_LOG="/var/log/syslog"

# Create logs directory if missing
mkdir -p "$LOG_DIR"

timestamp() {
    date +"%Y-%m-%d %H:%M:%S"
}

echo "[INFO] Monitoring started at $(timestamp)" | tee -a "$LOG_FILE"

# Check if system log exists
if [ ! -f "$SYSTEM_LOG" ]; then
    echo "[ERROR] System log file not found" | tee -a "$LOG_FILE"
    exit 1
fi

# Run grep but prevent it from breaking the script if no results
grep -iE "error|warning|critical|fail" "$SYSTEM_LOG" > "$ALERT_FILE" || true

echo "[SUCCESS] Alerts saved to: $ALERT_FILE" | tee -a "$LOG_FILE"


