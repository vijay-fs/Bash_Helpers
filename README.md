# DevQuery Helper

A collection of utility scripts to help developers manage their development environment and project files efficiently.

## Features

### 1. Generic Cleanup Tool (`cleanup.sh`)
A flexible script to safely remove files or folders matching specific patterns.

**Usage:**
```bash
./cleanup.sh [options] <directory_path>
```

**Options:**
- `-p, --pattern <pattern>`: Pattern to match (e.g., 'node_modules', '.env*', '*.log')
- `-t, --type <type>`: Type of item to clean (folder/file/both)
- `-d, --dry-run`: Show what would be deleted without actually deleting
- `-h, --help`: Show help message

**Examples:**
```bash
# Remove all node_modules folders
./cleanup.sh ~/Projects -p 'node_modules' -t folder

# Remove all .env files
./cleanup.sh ~/Projects -p '.env*' -t file

# Preview removal of all log files
./cleanup.sh ~/Projects -p '*.log' -t file --dry-run
```

**Features:**
- Flexible pattern matching for both files and folders
- Dry-run mode to preview changes
- Color-coded output for better visibility
- Size calculation before removal
- Interactive confirmation
- Detailed help documentation
- Graceful error handling
- Support for sudo operations when needed

### 2. Environment Files Backup Tool (`backup-env-files.sh`)
A script to safely backup all `.env` files from your projects directory to a specified backup location.

**Usage:**
```bash
./backup-env-files.sh <source_directory_path> <backup_directory_path>
```

**Example:**
```bash
./backup-env-files.sh ~/Projects ~/EnvBackups
```

**Features:**
- Recursively finds all `.env*` files in the specified directory
- Preserves directory structure in backup
- Interactive confirmation before backup
- Skips hidden directories
- Creates backup directory if it doesn't exist

## Installation

1. Clone this repository:
```bash
git clone <repository-url>
```

2. Make the scripts executable:
```bash
chmod +x *.sh
```

## Testing

A comprehensive test script (`test_cleanup.sh`) is provided to demonstrate various use cases of the cleanup tool:

```bash
./test_cleanup.sh
```

The test script will:
1. Create a temporary test environment with various files and folders
2. Test different cleanup scenarios:
   - Dry-run mode for node_modules folders
   - Removing node_modules folders
   - Dry-run mode for .env files
   - Removing .env files
   - Dry-run mode for log files
   - Removing log files
   - Dry-run mode for cache and temporary files
   - Removing cache and temporary files
   - Display help message
   - Test error handling
3. Clean up the test environment after completion

## Usage Guidelines

1. Always review the files that will be affected before running any script
2. Use the `--dry-run` option to preview changes before execution
3. Back up important data before running cleanup scripts
4. Use with caution in production environments
5. Ensure you have the necessary permissions to access and modify the target directories

## UX Features

1. **Visual Feedback:**
   - Color-coded output for better visibility
   - Progress indicators for long operations
   - Clear success/error messages

2. **Safety Features:**
   - Dry-run mode to preview changes
   - Interactive confirmation before deletion
   - Size calculation before removal
   - Graceful error handling

3. **Flexibility:**
   - Custom pattern matching
   - Support for both files and folders
   - Configurable options via command-line flags

4. **Documentation:**
   - Detailed help messages
   - Usage examples
   - Clear error messages

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, please open an issue in the repository or contact the maintainers. 