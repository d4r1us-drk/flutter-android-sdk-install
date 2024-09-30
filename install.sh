#!/usr/bin/env bash

# Check if XDG_LIB_HOME is set, if not, default to $HOME/.local/lib
if [ -z "$XDG_LIB_HOME" ]; then
    XDG_LIB_HOME="$HOME/.local/lib"
fi

# Define URLs
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.3-stable.tar.xz"
ANDROID_URL="https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip"

# Define install directories
FLUTTER_DIR="$XDG_LIB_HOME/flutter"
ANDROID_DIR="$XDG_LIB_HOME/android"
ANDROID_CMDLINE_TOOLS_DIR="$ANDROID_DIR/cmdline-tools/latest"

# Create necessary directories
mkdir -p "$FLUTTER_DIR"
mkdir -p "$ANDROID_DIR"
mkdir -p "$ANDROID_CMDLINE_TOOLS_DIR"

# Check if ANDROID_HOME and ANDROID_SDK_ROOT are set
if [ -z "$ANDROID_HOME" ] || [ -z "$ANDROID_SDK_ROOT" ]; then
    echo "Warning: ANDROID_HOME or ANDROID_SDK_ROOT are not set."
    echo "Please set them in your .profile or .bash_profile:"
    echo "  export ANDROID_HOME='$XDG_LIB_HOME/android'"
    echo "  export ANDROID_SDK_ROOT='$XDG_LIB_HOME/android'"
    echo "Then, run 'source ~/.profile' or 'source ~/.bash_profile' to apply the changes."
fi

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
unzip -q /tmp/android_tools.zip -d /tmp
mv /tmp/cmdline-tools/* "$ANDROID_CMDLINE_TOOLS_DIR"
rm -rf /tmp/cmdline-tools /tmp/android_tools.zip
echo "Android SDK Command Line Tools installed to $ANDROID_CMDLINE_TOOLS_DIR"
