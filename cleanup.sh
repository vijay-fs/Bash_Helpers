#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to show help
show_help() {
    echo -e "${YELLOW}DevQuery Helper - Generic Cleanup Tool${NC}"
    echo "Usage: $0 [options] <directory_path>"
    echo
    echo "Options:"
    echo "  -p, --pattern <pattern>    Pattern to match (e.g., 'node_modules', '.env*')"
    echo "  -t, --type <type>         Type of item to clean (folder/file/both)"
    echo "  -d, --dry-run            Show what would be deleted without actually deleting"
    echo "  -h, --help               Show this help message"
    echo
    echo "Examples:"
    echo "  $0 ~/Projects -p 'node_modules' -t folder"
    echo "  $0 ~/Projects -p '.env*' -t file"
    echo "  $0 ~/Projects -p '*.log' -t file --dry-run"
    echo
    echo "Default behavior:"
    echo "  - If no pattern is specified, defaults to 'node_modules'"
    echo "  - If no type is specified, defaults to 'folder'"
}

# Default values
PATTERN="node_modules"
TYPE="folder"
DRY_RUN=false
BASE_PATH=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--pattern)
            PATTERN="$2"
            shift 2
            ;;
        -t|--type)
            TYPE="$2"
            shift 2
            ;;
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            BASE_PATH="$1"
            shift
            ;;
    esac
done

# Check if directory path is provided
if [ -z "$BASE_PATH" ]; then
    echo -e "${RED}Error: Directory path is required${NC}"
    show_help
    exit 1
fi

# Check if the provided path exists
if [ ! -d "$BASE_PATH" ]; then
    echo -e "${RED}Error: Directory '$BASE_PATH' does not exist${NC}"
    exit 1
fi

# Function to find items based on type and pattern
find_items() {
    local search_type="$1"
    local search_pattern="$2"
    
    if [ "$search_type" = "folder" ]; then
        find "$BASE_PATH" -type d -name "$search_pattern" -print
    elif [ "$search_type" = "file" ]; then
        find "$BASE_PATH" -type f -name "$search_pattern" -print
    else
        find "$BASE_PATH" -type d -name "$search_pattern" -print
        find "$BASE_PATH" -type f -name "$search_pattern" -print
    fi
}

# Find items based on criteria
echo -e "${YELLOW}Searching for items matching pattern '$PATTERN' in '$BASE_PATH'...${NC}"
ITEMS=$(find_items "$TYPE" "$PATTERN")

# Count the number of items found
NUM_ITEMS=$(echo "$ITEMS" | grep -c "^")

if [ $NUM_ITEMS -eq 0 ]; then
    echo -e "${YELLOW}No items found matching the criteria.${NC}"
    exit 0
fi

# Calculate total size
echo -e "${YELLOW}Found $NUM_ITEMS items. Calculating total size...${NC}"
TOTAL_SIZE=$(du -ch $ITEMS 2>/dev/null | grep total$ | cut -f1)

# Show what would be deleted in dry-run mode
if [ "$DRY_RUN" = true ]; then
    echo -e "${GREEN}Dry run mode - would delete the following items:${NC}"
    echo "$ITEMS"
    echo -e "${YELLOW}Total size that would be freed: $TOTAL_SIZE${NC}"
    exit 0
fi

# Ask for confirmation
echo -e "${YELLOW}Total size of items to be removed: $TOTAL_SIZE${NC}"
echo -e "${RED}Do you want to remove these items? (y/n)${NC}"
read -r CONFIRM

if [ "$CONFIRM" = "y" ] || [ "$CONFIRM" = "Y" ]; then
    echo -e "${YELLOW}Removing items...${NC}"
    
    # Remove items
    if [ "$TYPE" = "folder" ]; then
        find "$BASE_PATH" -type d -name "$PATTERN" -exec rm -rf {} \; 2>/dev/null || {
            echo -e "${RED}Some directories could not be removed. You might need to run with sudo.${NC}"
            echo -e "${YELLOW}Try: sudo $0 $BASE_PATH -p '$PATTERN' -t $TYPE${NC}"
            exit 1
        }
    elif [ "$TYPE" = "file" ]; then
        find "$BASE_PATH" -type f -name "$PATTERN" -exec rm -f {} \; 2>/dev/null || {
            echo -e "${RED}Some files could not be removed. You might need to run with sudo.${NC}"
            echo -e "${YELLOW}Try: sudo $0 $BASE_PATH -p '$PATTERN' -t $TYPE${NC}"
            exit 1
        }
    else
        find "$BASE_PATH" -type d -name "$PATTERN" -exec rm -rf {} \; 2>/dev/null
        find "$BASE_PATH" -type f -name "$PATTERN" -exec rm -f {} \; 2>/dev/null
    fi
    
    echo -e "${GREEN}Successfully removed all matching items!${NC}"
    echo -e "${GREEN}Freed up approximately $TOTAL_SIZE of disk space.${NC}"
else
    echo -e "${YELLOW}Operation cancelled. No items were removed.${NC}"
fi 