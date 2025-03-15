#!/bin/bash
# Local build script for development testing

# Determine OS and architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

echo "Detected OS: $OS, Architecture: $ARCH"

# Install dependencies
pip install -r requirements.txt
pip install nuitka ordered-set zstandard

if [[ "$OS" == "Darwin" ]]; then  # macOS
    if [[ "$ARCH" == "arm64" ]]; then
        echo "Building for macOS ARM64..."
        python -m nuitka --standalone --macos-create-app-bundle --macos-target-arch=arm64 \
            --follow-imports --disable-ccache \
            --output-dir=dist src/ai_chat/main.py
    else
        echo "Building for macOS x86_64..."
        python -m nuitka --standalone --macos-create-app-bundle --macos-target-arch=x86_64 \
            --follow-imports --disable-ccache \
            --output-dir=dist src/ai_chat/main.py
    fi
    
    # Create DMG (optional)
    hdiutil create -volname "AI Chat" -srcfolder dist/main.app -ov -format UDZO dist/AIChat.dmg
    
elif [[ "$OS" == "Linux" ]]; then  # Linux
    echo "Building for Linux..."
    python -m nuitka --standalone \
        --follow-imports --disable-ccache \
        --output-dir=dist src/ai_chat/main.py
        
elif [[ "$OS" == "MINGW"* || "$OS" == "MSYS"* ]]; then  # Windows
    echo "Building for Windows..."
    if [[ "$ARCH" == "x86_64" ]]; then
        python -m nuitka --standalone --msvc=latest --windows-icon-from-ico=icon.ico \
            --follow-imports --disable-ccache \
            --output-dir=dist src/ai_chat/main.py
    else
        python -m nuitka --standalone --msvc=latest --windows-icon-from-ico=icon.ico \
            --follow-imports --disable-ccache \
            --output-dir=dist src/ai_chat/main.py
    fi
else
    echo "Unsupported OS: $OS"
    exit 1
fi

echo "Build complete! Check the 'dist' directory for your compiled application." 