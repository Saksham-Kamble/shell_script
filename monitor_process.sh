#!/bin/bash

# Process Monitoring Script
# Usage: ./monitor_process.sh <process_name>

# Function to check if the process is running
check_process() {
    pgrep "$1" > /dev/null
    return $?
}

# Function to restart the process
restart_process() {
    echo "Attempting to restart $1..."
    # Replace <command_to_start_process> with the actual command
    case $1 in
        process_name)
            <command_to_start_process> &
            ;;
        *)
            echo "Unknown process: $1"
            return 1
            ;;
    esac
    return 0
}

# Main script
if [ $# -ne 1 ]; then
    echo "Usage: $0 <process_name>"
    exit 1
fi

PROCESS_NAME="$1"
MAX_RESTART_ATTEMPTS=3
RESTART_COUNT=0

# Check if the process is running
if check_process "$PROCESS_NAME"; then
    echo "$PROCESS_NAME is running."
else
    echo "$PROCESS_NAME is not running."
    
    # Attempt to restart the process
    while [ $RESTART_COUNT -lt $MAX_RESTART_ATTEMPTS ]; do
        restart_process "$PROCESS_NAME"
        if check_process "$PROCESS_NAME"; then
            echo "$PROCESS_NAME restarted successfully."
            exit 0
        fi
        ((RESTART_COUNT++))
        echo "Restart attempt $RESTART_COUNT failed."
    done

    # Notify if all restart attempts failed
    echo "Failed to restart $PROCESS_NAME after $MAX_RESTART_ATTEMPTS attempts."
    # Add notification mechanism here (e.g., email or Slack message)
fi

# Scheduling Instructions
echo "To schedule this script to run every minute, add the following line to your crontab:"
echo "* * * * * /path/to/monitor_process.sh $PROCESS_NAME"
