#!/bin/bash
set -e  # Stop on any error

# Menu file does not need logs
# It simply calls other scripts

echo "========== SYSTEM MAINTENANCE SUITE =========="
echo "1. Run Backup"
echo "2. Run System Update"
echo "3. Monitor System Logs"
echo "4. Exit"
echo "=============================================="
echo -n "Choose an option: "
read CHOICE

case $CHOICE in
    1)
        ./backup_Script.sh
        ;;
    2)
        ./update_Clean.sh
        ;;
    3)
        ./log_monitoring.sh
        ;;
    4)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac
