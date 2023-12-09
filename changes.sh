#!/bin/bash

# Define paths to monitor
directories_to_monitor=("/home/miles")

# Enable auditing for directories
for directory in "${directories_to_monitor[@]}"; do
    auditctl -w "$directory" -p wa -k monitor_directory
done

# Check audit logs for changes
ausearch -k monitor_directory --raw |
while IFS= read -r line; do
    echo "Change detected at $(date): $line"
    # Log changes to a file or perform desired actions
    # Example: echo "Change detected at $(date): $line" >> /var/log/audit_changes.log
done