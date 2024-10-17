#!/bin/bash

# Day 1 Bash Scripting Challenge

# Task 1: Comments
# This bash script demonstrates the basics of bash scripting: comments, echo, variables, built-in variables, and wildcards.

# Task 2: Echo
# Using the echo command to print a message
echo "Welcome to the Bash Scripting Challenge! Let's learn some scripting basics."

# Task 3: Variables
# Declaring variables and assigning values to them
name="Saksham"
course="DevOps"
echo "Hello, $name! You are working on a $course bash scripting challenge."

# Task 4: Using Variables
# Declaring two number variables and calculating their sum
num1=15
num2=30
sum=$((num1 + num2))
echo "The sum of $num1 and $num2 is: $sum"

# Task 5: Using Built-in Variables
# Using built-in variables to display useful information
echo "Current script name: $0"
echo "Number of arguments passed to the script: $#"
echo "Current working directory: $PWD"
echo "Home directory: $HOME"

# Task 6: Wildcards
# Using wildcards to list all files with a specific extension (e.g., .sh) in the current directory
echo "Listing all .sh files in the current directory:"
ls *.sh


