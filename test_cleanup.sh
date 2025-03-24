#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Create a test directory
TEST_DIR="test_cleanup"
echo -e "${YELLOW}Creating test directory: $TEST_DIR${NC}"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

# Create test files and directories
echo -e "${YELLOW}Creating test files and directories...${NC}"

# Create node_modules directories
mkdir -p project1/node_modules
mkdir -p project2/node_modules
mkdir -p project3/node_modules

# Create .env files
touch project1/.env
touch project1/.env.local
touch project2/.env
touch project2/.env.production

# Create log files
touch project1/app.log
touch project1/error.log
touch project2/debug.log
touch project2/access.log

# Create cache files
touch project1/.cache
touch project2/.cache
touch project3/.cache

# Create temporary files
touch project1/tmp_file
touch project2/tmp_file
touch project3/tmp_file

echo -e "${GREEN}Test environment created successfully!${NC}"
echo -e "${YELLOW}Running cleanup tests...${NC}"

# Test 1: Dry run for node_modules
echo -e "\n${YELLOW}Test 1: Dry run for node_modules folders${NC}"
../cleanup.sh . -p 'node_modules' -t folder --dry-run

# Test 2: Remove node_modules
echo -e "\n${YELLOW}Test 2: Remove node_modules folders${NC}"
../cleanup.sh . -p 'node_modules' -t folder

# Test 3: Dry run for .env files
echo -e "\n${YELLOW}Test 3: Dry run for .env files${NC}"
../cleanup.sh . -p '.env*' -t file --dry-run

# Test 4: Remove .env files
echo -e "\n${YELLOW}Test 4: Remove .env files${NC}"
../cleanup.sh . -p '.env*' -t file

# Test 5: Dry run for log files
echo -e "\n${YELLOW}Test 5: Dry run for log files${NC}"
../cleanup.sh . -p '*.log' -t file --dry-run

# Test 6: Remove log files
echo -e "\n${YELLOW}Test 6: Remove log files${NC}"
../cleanup.sh . -p '*.log' -t file

# Test 7: Dry run for both cache and tmp files
echo -e "\n${YELLOW}Test 7: Dry run for both cache and tmp files${NC}"
../cleanup.sh . -p '.cache' -t both --dry-run
../cleanup.sh . -p 'tmp_file' -t both --dry-run

# Test 8: Remove both cache and tmp files
echo -e "\n${YELLOW}Test 8: Remove both cache and tmp files${NC}"
../cleanup.sh . -p '.cache' -t both
../cleanup.sh . -p 'tmp_file' -t both

# Test 9: Show help
echo -e "\n${YELLOW}Test 9: Show help message${NC}"
../cleanup.sh --help

# Test 10: Test error handling
echo -e "\n${YELLOW}Test 10: Test error handling (non-existent directory)${NC}"
../cleanup.sh non_existent_dir

echo -e "\n${GREEN}All tests completed!${NC}"
echo -e "${YELLOW}Cleaning up test directory...${NC}"
cd ..
rm -rf "$TEST_DIR"
echo -e "${GREEN}Test directory removed.${NC}" 