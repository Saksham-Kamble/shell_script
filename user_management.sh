#!/bin/bash

# User Account Management Script

# Function to display help message
show_help() {
    echo "Usage: $0 [options]"
    echo "-c, --create   Create a new user account"
    echo "-d, --delete   Delete an existing user account"
    echo "-r, --reset    Reset the password of an existing user"
    echo "-l, --list     List all user accounts"
    echo "-h, --help     Display this help message"
}

# Function to create a user
create_user() {
    read -p "Enter new username: " username
    read -s -p "Enter password: " password
    echo
    # Check if user exists
    if id "$username" &>/dev/null; then
        echo "Username '$username' already exists!"
        exit 1
    else
        # Create user
        useradd -m -p "$(openssl passwd -1 "$password")" "$username"
        echo "User account created successfully: $username"
    fi
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username
    if id "$username" &>/dev/null; then
        userdel -r "$username"
        echo "User account '$username' deleted successfully."
    else
        echo "Username '$username' does not exist!"
        exit 1
    fi
}

# Function to reset password
reset_password() {
    read -p "Enter username: " username
    if id "$username" &>/dev/null; then
        read -s -p "Enter new password: " password
        echo
        echo "$username:$(openssl passwd -1 "$password")" | chpasswd
        echo "Password for '$username' reset successfully."
    else
        echo "Username '$username' does not exist!"
        exit 1
    fi
}

# Function to list users
list_users() {
    echo "User accounts:"
    awk -F':' '{ print $1, "(UID: " $3 ")" }' /etc/passwd
}

# Check for command line arguments
case "$1" in
    -c|--create)
        create_user
        ;;
    -d|--delete)
        delete_user
        ;;
    -r|--reset)
        reset_password
        ;;
    -l|--list)
        list_users
        ;;
    -h|--help)
        show_help
        ;;
    *)
        echo "Invalid option!"
        show_help
        exit 1
        ;;
esac
