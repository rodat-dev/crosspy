@echo off
rem Windows build script for development testing

echo Detecting architecture...
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo Building for Windows x64...
    set ARCH_FLAG=--msvc=latest
) else (
    echo Building for Windows x86...
    set ARCH_FLAG=--msvc=latest
)

echo Installing dependencies...
pip install -r requirements.txt
pip install nuitka ordered-set zstandard

echo Building application...
python -m nuitka --standalone %ARCH_FLAG% --windows-icon-from-ico=icon.ico ^
    --follow-imports --disable-ccache ^
    --output-dir=dist src/ai_chat/main.py

echo Build complete! Check the 'dist' directory for your compiled application. 