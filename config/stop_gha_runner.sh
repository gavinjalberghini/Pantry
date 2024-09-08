#!/bin/bash

# Find and stop all active GitHub Actions runner processes
echo "Stopping GitHub Actions runner processes..."

# Use pgrep to find processes matching 'actions.runner' and kill them
pkill -f 'actions.runner' && echo "GitHub Actions runner processes stopped." || echo "No GitHub Actions runner processes found."

# Optionally, you can provide more detailed process management if needed:
# pgrep -f 'actions.runner' | xargs kill -9
