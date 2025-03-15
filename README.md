# AI Chat Application

A cross-platform Python application for interacting with OpenAI's GPT models.

## Requirements

- Python 3.11 or higher
- pip package manager

## Building from Source

This repository contains everything needed to build the application for multiple platforms:

### Local Development Builds

#### macOS and Linux
```bash
# Make the script executable
chmod +x build.sh

# Run the build script
./build.sh
```

#### Windows
```cmd
# Run the build script
build.bat
```

### Using GitHub Actions

The repository contains GitHub Actions workflows that automatically build the application for:
- macOS ARM64 (Apple Silicon)
- macOS x86_64 (Intel)
- Windows 64-bit
- Windows 32-bit

To trigger a build manually:
1. Go to the "Actions" tab in GitHub
2. Select the "Build AI Chat App" workflow
3. Click "Run workflow"
4. The compiled binaries will be available as artifacts after the build is complete

## Platform-Specific Notes

### macOS

The macOS build creates a `.app` bundle that can be installed by dragging it to your Applications folder. It also creates a DMG file for easy distribution.

### Windows

The Windows build creates a standalone executable with all dependencies included.

## Custom Builds

If you need to customize the build process, you can modify the Nuitka parameters in the build scripts or GitHub Actions workflow. 