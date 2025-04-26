#!/bin/bash

# Check if log file path is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_log_file>"
    exit 1
fi

LOG_FILE=$1

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' not found!"
    exit 1
fi

# Initialize variables
TOTAL_LINES=0
ERROR_COUNT=0
declare -A ERROR_MESSAGES
CRITICAL_EVENTS=()

# Process the log file
while IFS= read -r line; do
    ((TOTAL_LINES++))

    # Count error messages
    if [[ "$line" == *"ERROR"* ]] || [[ "$line" == *"Failed"* ]]; then
        ((ERROR_COUNT++))

        # Extract error message (assumed to be everything after the keyword)
        error_message=${line#*ERROR }
        error_message=${error_message#*Failed }

        # Count occurrences of each error message
        ((ERROR_MESSAGES["$error_message"]++))
    fi

    # Check for critical events
    if [[ "$line" == *"CRITICAL"* ]]; then
        CRITICAL_EVENTS+=("$line")
    fi
done < "$LOG_FILE"

# Prepare to generate the summary report
REPORT_FILE="summary_report_$(date +%Y%m%d).txt"

# Write summary report to file
{
    echo "Date of Analysis: $(date)"
    echo "Log File Name: $(basename "$LOG_FILE")"
    echo "Total Lines Processed: $TOTAL_LINES"
    echo "Total Error Count: $ERROR_COUNT"
    echo "Top 5 Error Messages:"

    # Sort and display top 5 error messages
    for msg in "${!ERROR_MESSAGES[@]}"; do
        echo "$msg: ${ERROR_MESSAGES[$msg]}"
    done | sort -rn -k2 | head -n 5

    echo ""
    echo "Critical Events:"
    for line in "${CRITICAL_EVENTS[@]}"; do
        echo "$line"
    done
} > "$REPORT_FILE"

echo "Summary report generated: $REPORT_FILE"

# Optional: Move the processed log file to an archive directory
ARCHIVE_DIR="./archive"
mkdir -p "$ARCHIVE_DIR"
mv "$LOG_FILE" "$ARCHIVE_DIR/"

echo "Log file moved to archive directory: $ARCHIVE_DIR/"
