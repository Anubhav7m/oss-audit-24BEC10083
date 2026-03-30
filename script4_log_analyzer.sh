#!/bin/bash
# =============================================================
# Script 4: Log File Analyzer
# Author: Anubhav Mishra
# Registration: 24BEC10083
# Course: Open Source Software | Units 2 & 5
# Description: Reads a log file line by line, counts occurrences
#              of a keyword, prints a summary, and shows the last
#              5 matching lines. Demonstrates while-read loop,
#              if-then logic, counter variables, and $1/$2 args.
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
#        Example: ./script4_log_analyzer.sh /var/log/syslog error
# =============================================================

# --- Command-line arguments ---
LOGFILE=$1                    # First argument: path to the log file
KEYWORD=${2:-"error"}         # Second argument: keyword to search for (default: "error")

echo "================================================================"
echo "  LOG FILE ANALYZER"
echo "  Generated: $(date '+%Y-%m-%d %H:%M:%S')"
echo "================================================================"

# --- Validate that the log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo ""
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo ""
    exit 1
fi

# --- Check if the file exists ---
if [ ! -f "$LOGFILE" ]; then
    echo ""
    echo "  ERROR: File '$LOGFILE' not found."
    echo ""

    # --- Retry logic: suggest common log file locations ---
    # This simulates a do-while retry: prompt alternative paths to try.
    echo "  Common log file locations to try:"
    COMMON_LOGS=("/var/log/syslog" "/var/log/messages" "/var/log/kern.log" "/var/log/auth.log")
    for LOG in "${COMMON_LOGS[@]}"; do
        if [ -f "$LOG" ]; then
            echo "    [FOUND] $LOG"
        else
            echo "    [N/A]   $LOG"
        fi
    done
    echo ""
    exit 1
fi

# --- Check if the file is empty ---
if [ ! -s "$LOGFILE" ]; then
    echo ""
    echo "  WARNING: The file '$LOGFILE' exists but is empty."
    echo "  No analysis can be performed on an empty file."
    echo ""
    exit 0
fi

echo ""
echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo "  File Size: $(du -sh "$LOGFILE" | cut -f1)"
echo ""
echo "----------------------------------------------------------------"
echo "  Scanning file..."
echo "----------------------------------------------------------------"

# --- Initialise counter variables ---
COUNT=0          # Counts lines matching the keyword
TOTAL=0          # Counts total lines processed

# --- While-read loop: read the file one line at a time ---
# IFS= prevents leading/trailing whitespace from being stripped
# -r prevents backslash interpretation
while IFS= read -r LINE; do
    # Increment total line counter
    TOTAL=$((TOTAL + 1))

    # If-then: check if the current line contains the keyword (case-insensitive via -i)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment the match counter
    fi

done < "$LOGFILE"   # Redirect file content as input to the while loop

echo ""
echo "  RESULTS:"
echo "  Total lines scanned : $TOTAL"
echo "  Lines matching '$KEYWORD' : $COUNT"

# --- Calculate percentage if total > 0 to avoid divide-by-zero ---
if [ "$TOTAL" -gt 0 ]; then
    # Use awk for floating-point arithmetic (bash only does integers)
    PERCENT=$(awk "BEGIN { printf \"%.1f\", ($COUNT / $TOTAL) * 100 }")
    echo "  Match percentage    : $PERCENT%"
fi

# --- Show the last 5 matching lines using grep + tail ---
echo ""
echo "----------------------------------------------------------------"
echo "  LAST 5 LINES CONTAINING '$KEYWORD':"
echo "----------------------------------------------------------------"

# grep -i for case-insensitive search; tail -5 to get last 5 matches
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

if [ -n "$MATCHES" ]; then
    # Print each matching line with a line indicator
    echo "$MATCHES" | while IFS= read -r MATCH_LINE; do
        echo "  > $MATCH_LINE"
    done
else
    echo "  No matching lines found."
fi

echo ""
echo "================================================================"
echo "  END OF LOG ANALYSIS"
echo "================================================================"
