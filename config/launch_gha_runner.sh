#!/bin/bash

# Navigate to the actions-runner directory
cd ~/actions-runner || { echo "Directory ~/actions-runner not found."; exit 1; }

# Execute the run.sh script in the background
./run.sh &

# Optionally, you can capture the process ID (PID) and log it
echo "Started ./run.sh with PID $!"
