#!/bin/bash

# Function to display system metrics
function display_metrics {
    echo "------ System Metrics ------"
    echo "CPU Usage:"
    top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4 "% used"}'
    
    echo "Memory Usage:"
    free -h | awk '/^Mem:/ {print $3 "/" $2 " used"}'
    
    echo "Disk Space Usage:"
    df -h | awk '$1 != "Filesystem" {print $1 ": " $3 "/" $2 " used"}'
    echo "---------------------------"
}

# Function to show the menu
function show_menu {
    echo "Welcome to the System Monitoring Script"
    echo "1. View System Metrics"
    echo "2. Exit"
}

# Main loop
while true; do
    show_menu
    read -p "Please select an option (1-2): " choice
    
    case $choice in
        1)
            display_metrics
            ;;
        2)
            echo "Exiting the script. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please select again."
            ;;
    esac
    
    # Optional: Sleep for a specified interval before showing the menu again
    sleep 5  # Adjust the sleep time as needed
done
