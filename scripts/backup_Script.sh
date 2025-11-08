#!/bin/bash
set -e  # Stop script on any error

LOG_FILE="../logs/backup.log"
BACKUP_DIR="../backups"

timestamp() {
    date +"%Y-%m-%d %H:%M:%S"
}

echo "[INFO] Backup started at $(timestamp)" | tee -a "$LOG_FILE"

# Ensure backups directory exists
[ -d "$BACKUP_DIR" ] || mkdir -p "$BACKUP_DIR"

# Ask which file/folder to back up
echo -n "Enter FULL PATH of file or folder to backup: "
read TARGET

[ -z "$TARGET" ] && { echo "[ERROR] Nothing entered" | tee -a "$LOG_FILE"; exit 1; }
[ -e "$TARGET" ] || { echo "[ERROR] Target not found" | tee -a "$LOG_FILE"; exit 1; }

# Confirm backup
echo -n "Do you want to back up '$TARGET'? (yes/no): "
read CONFIRM

# Convert to lowercase for easy checking
CONFIRM=$(echo "$CONFIRM" | tr 'A-Z' 'a-z')

if [ "$CONFIRM" != "yes" ] && [ "$CONFIRM" != "y" ]; then
    echo "[INFO] Backup cancelled" | tee -a "$LOG_FILE"
    exit 0
fi


# Create backup file name
BACKUP_NAME="backup_$(basename "$TARGET")_$(date +%Y%m%d_%H%M%S).tar.gz"

# Perform backup
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$TARGET"

echo "[SUCCESS] Backup saved as $BACKUP_NAME" | tee -a "$LOG_FILE"
