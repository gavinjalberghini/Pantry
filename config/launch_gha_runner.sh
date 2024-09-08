#!/bin/bash

# Navigate to the actions-runner directory
cd ~/actions-runner || { echo "Directory ~/actions-runner not found."; exit 1; }

# Check if the script is already running
if pgrep -f 'run.sh' > /dev/null; then
	  echo "run.sh is already running." 
	    exit 1
fi

# Define log file name with a timestamp
log_file="/home/galberghini/actions-runner/runner.log"
date_time="$(date +'%Y-%m-%d_%H-%M-%S')"
echo "$date_time : Launched runner service.." >> "$log_file"

# Execute the run.sh script in the background
./run.sh >> "$log_file" 2>&1 &
echo "Started ./run.sh with PID $!"

