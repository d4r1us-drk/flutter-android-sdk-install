#!/usr/bin/env bash

# Check if XDG_LIB_HOME is set, if not, default to $HOME/.local/lib
if [ -z "$XDG_LIB_HOME" ]; then
    XDG_LIB_HOME="$HOME/.local/lib"
fi

# Define URLs
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.2-stable.tar.xz"
ANDROID_URL="https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip"

# Define install directories
FLUTTER_DIR="$XDG_LIB_HOME/flutter"
ANDROID_DIR="$XDG_LIB_HOME/android"

# Create necessary directories
mkdir -p "$FLUTTER_DIR"
mkdir -p "$ANDROID_DIR"

# Download and install Flutter SDK
echo "Downloading Flutter SDK..."
curl -L "$FLUTTER_URL" -o /tmp/flutter.tar.xz
echo "Extracting Flutter SDK..."
tar -xf /tmp/flutter.tar.xz -C "$FLUTTER_DIR" --strip-components=1
rm /tmp/flutter.tar.xz
echo "Flutter SDK installed to $FLUTTER_DIR"

# Download and install Android SDK Command Line Tools
echo "Downloading Android SDK Command Line Tools..."
curl -L "$ANDROID_URL" -o /tmp/android_tools.zip
echo "Extracting Android SDK Command Line Tools..."
unzip /tmp/android_tools.zip -d "$ANDROID_DIR"
rm /tmp/android_tools.zip
echo "Android SDK Command Line Tools installed to $ANDROID_DIR"
