#!/bin/bash

# Check if both source and backup path arguments are provided
if [ $# -lt 2 ]; then
  echo "Usage: $0 <source_directory_path> <backup_directory_path>"
  echo "Example: $0 ~/Projects ~/EnvBackups"
  exit 1
fi

SOURCE_PATH="$1"
BACKUP_PATH="$2"

# Check if the source path exists
if [ ! -d "$SOURCE_PATH" ]; then
  echo "Error: Source directory '$SOURCE_PATH' does not exist"
  exit 1
fi

# Create backup directory if it doesn't exist
if [ ! -d "$BACKUP_PATH" ]; then
  mkdir -p "$BACKUP_PATH"
  echo "Created backup directory: $BACKUP_PATH"
fi

echo "Searching for .env files in '$SOURCE_PATH'..."

# Find all .env* files
ENV_FILES=$(find "$SOURCE_PATH" -type f -name ".env*" -not -path "*/\.*/*" -print)

# Count the number of files found
NUM_FILES=$(echo "$ENV_FILES" | grep -c "^")

if [ $NUM_FILES -eq 0 ]; then
  echo "No .env files found."
  exit 0
fi

echo "Found $NUM_FILES .env files."

# Ask for confirmation
echo "Do you want to backup these files to '$BACKUP_PATH'? (y/n)"
read -r CONFIRM

if [ "$CONFIRM" = "y" ] || [ "$CONFIRM" = "Y" ]; then
  # Process each .env file
  while IFS= read -r file; do
    # Get the relative path (strip the source path)
    REL_PATH=${file#"$SOURCE_PATH"}
    
    # Create target directory
    TARGET_DIR="$BACKUP_PATH$(dirname "$REL_PATH")"
    mkdir -p "$TARGET_DIR"
    
    # Copy the file
    cp "$file" "$TARGET_DIR/"
    
    echo "Backed up: $file -> $TARGET_DIR/$(basename "$file")"
  done <<< "$ENV_FILES"
  
  echo "Successfully backed up all .env files to '$BACKUP_PATH'!"
else
  echo "Operation cancelled. No files were backed up."
fi