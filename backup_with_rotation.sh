#!/bin/bash

# Day 2 Bash Scripting Challenge - Directory Backup with Rotation

# Check if a directory path is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# Define variables
directory_to_backup=$1
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
backup_dir="$directory_to_backup/backup_$timestamp"

# Check if the directory exists
if [ ! -d "$directory_to_backup" ]; then
    echo "The specified directory does not exist!"
    exit 1
fi

# Part 1: Creating a Backup
# Create a new backup folder with a timestamp
mkdir -p "$backup_dir"
if [ $? -eq 0 ]; then
    echo "Backup created: $backup_dir"
else
    echo "Failed to create the backup directory!"
    exit 1
fi

# Copy all the contents of the directory to the backup folder
cp -r "$directory_to_backup"/* "$backup_dir"
if [ $? -eq 0 ]; then
    echo "Files copied successfully to $backup_dir"
else
    echo "Failed to copy files!"
    exit 1
fi

# Part 2: Backup Rotation (Keep only the last 3 backups)
# Find all the backup directories and sort them by creation time (oldest first)
backup_dirs=($(ls -dt "$directory_to_backup"/backup_* 2>/dev/null))

# Check if more than 3 backup directories exist
if [ ${#backup_dirs[@]} -gt 3 ]; then
    # Calculate how many backups need to be deleted
    delete_count=$((${#backup_dirs[@]} - 3))

    # Remove the oldest backups
    for ((i=0; i<$delete_count; i++)); do
        rm -rf "${backup_dirs[$i]}"
        if [ $? -eq 0 ]; then
            echo "Deleted old backup: ${backup_dirs[$i]}"
        else
            echo "Failed to delete: ${backup_dirs[$i]}"
        fi
    done
fi
