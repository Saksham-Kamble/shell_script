#!/bin/bash

# Day 2 Bash Scripting Challenge - Interactive File and Directory Explorer

# Part 1: File and Directory Exploration
# Display a welcome message and list files and directories in human-readable format
echo "Welcome to the Interactive File and Directory Explorer!"

# Infinite loop to keep displaying the files and directories until the user chooses to exit
while true; do
    echo "Files and Directories in the Current Path:"
    
    # List files and directories with their sizes in human-readable format (e.g., KB, MB, GB)
    ls -lh
    
    # Prompt the user to continue or exit
    echo ""
    echo "Press 'q' to exit the explorer or 'c' to continue."
    read -p "Your choice: " user_choice
    
    # If the user presses 'q', break the loop and exit
    if [[ "$user_choice" == "q" ]]; then
        echo "Exiting the Interactive Explorer. Goodbye!"
        break
    fi

    # Part 2: Character Counting
    while true; do
        # Prompt the user to enter a line of text
        echo ""
        read -p "Enter a line of text (Press Enter without text to exit): " user_input
        
        # Check if the input is empty (user pressed Enter without typing anything)
        if [[ -z "$user_input" ]]; then
            echo "Exiting character count mode."
            break
        fi
        
        # Count the number of characters in the input string and display the result
        char_count=${#user_input}
        echo "Character Count: $char_count"
    done
done
