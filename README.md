# DevQuery Helper

A collection of utility scripts to help developers manage their development environment and project files efficiently.

## Features

### 1. Environment Files Backup Tool (`backup-env-files.sh`)
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

### 2. Node Modules Cleanup Tool (`remove-node-modules.sh`)
A script to safely remove all `node_modules` directories and free up disk space.

**Usage:**
```bash
./remove-node-modules.sh <directory_path>
```

**Example:**
```bash
./remove-node-modules.sh ~/Projects
```

**Features:**
- Recursively finds all `node_modules` directories
- Shows total size before removal
- Interactive confirmation before deletion
- Handles permission issues gracefully
- Provides sudo instructions if needed

## Installation

1. Clone this repository:
```bash
git clone <repository-url>
```

2. Make the scripts executable:
```bash
chmod +x *.sh
```

## Usage Guidelines

1. Always review the files that will be affected before running any script
2. Back up important data before running cleanup scripts
3. Use with caution in production environments
4. Ensure you have the necessary permissions to access and modify the target directories

## UX Suggestions

1. **Visual Feedback:**
   - Add progress bars for long operations
   - Implement color-coded output for success/error messages
   - Add ASCII art or icons for better visual appeal

2. **Interactive Features:**
   - Add a dry-run mode to preview changes
   - Implement undo functionality for accidental deletions
   - Add file size formatting options (MB/GB)

3. **Error Handling:**
   - Add more detailed error messages
   - Implement automatic error logging
   - Add recovery options for failed operations

4. **Configuration:**
   - Add a configuration file for default settings
   - Implement command-line flags for common options
   - Add support for custom file patterns

5. **Documentation:**
   - Add inline help with `--help` flag
   - Include examples in the help text
   - Add man pages for Unix-like systems

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, please open an issue in the repository or contact the maintainers. 