#!/bin/bash

# Set the log file you want to monitor (e.g., auth.log or secure.log)
LOG_FILE="/var/log/auth.log"

# Set the specific user you want to monitor
TARGET_USER="miles"

# Set the time to midnight to 6 AM
START_TIME="00:00:00"
END_TIME="06:00:00"

# Extract logins for a specific user between the specified time 
grep "$TARGET_USER" "$LOG_FILE" | awk -v start="$START_TIME" -v end="$END_TIME" '$0 >= start && $0 <= end' >> temp_log.txt

# Extract IP addresses from the filtered log
awk '{ for (i=1; i<=NF; i++) if ($i ~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/) print $i }' temp_log.txt | sort -u >> detected_ips.txt

# Display the detected IP addresses
echo "Detected IP addresses attempting to access between $START_TIME and $END_TIME for user: $TARGET_USER"
cat detected_ips.txt

# Clean up temporary files
rm temp_log.txt detected_ips.txt
