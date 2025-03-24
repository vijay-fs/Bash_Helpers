#!/bin/bash

# Check if path argument is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <directory_path>"
  echo "Example: $0 ~/Projects"
  exit 1
fi

BASE_PATH="$1"

# Check if the provided path exists
if [ ! -d "$BASE_PATH" ]; then
  echo "Error: Directory '$BASE_PATH' does not exist"
  exit 1
fi

echo "Searching for node_modules directories in '$BASE_PATH'..."

# Find all node_modules directories
NODE_MODULES_DIRS=$(find "$BASE_PATH" -type d -name "node_modules" -print)

# Count the number of directories found
NUM_DIRS=$(echo "$NODE_MODULES_DIRS" | grep -c "node_modules")

if [ $NUM_DIRS -eq 0 ]; then
  echo "No node_modules directories found."
  exit 0
fi

# Calculate total size before removal
echo "Found $NUM_DIRS node_modules directories. Calculating total size..."
TOTAL_SIZE=$(du -ch $NODE_MODULES_DIRS | grep total$ | cut -f1)

echo "Total size of all node_modules directories: $TOTAL_SIZE"
echo "Do you want to remove these directories? (y/n)"
read -r CONFIRM

if [ "$CONFIRM" = "y" ] || [ "$CONFIRM" = "Y" ]; then
  echo "Removing node_modules directories..."
  
  # Remove each node_modules directory
  find "$BASE_PATH" -type d -name "node_modules" -exec rm -rf {} \; 2>/dev/null || {
    echo "Some directories could not be removed. You might need to run with sudo."
    echo "Try: sudo $0 $BASE_PATH"
    exit 1
  }
  
  echo "Successfully removed all node_modules directories!"
  echo "Freed up approximately $TOTAL_SIZE of disk space."
else
  echo "Operation cancelled. No directories were removed."
fi
