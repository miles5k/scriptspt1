#!/bin/bash

# Set the directory to monitor (e.g., /var/log or /etc)
MONITORED_DIR="/var/log"

# Function to calculate hash of files in the directory
calculate_hashes() {
    find "$1" -type f -exec md5sum {} + | sort
}

# Initial hash calculation
initial_hashes=$(calculate_hashes "$MONITORED_DIR")

while true; do
    # Calculate hashes of current files
    current_hashes=$(calculate_hashes "$MONITORED_DIR")

    # Compare current hashes with initial hashes
    changes=$(diff <(echo "$initial_hashes") <(echo "$current_hashes"))

    if [ -n "$changes" ]; then
        echo "Changes detected in $MONITORED_DIR:"
        echo "$changes"
        initial_hashes="$current_hashes"  # Update initial hashes
    fi

    sleep 5  
done
