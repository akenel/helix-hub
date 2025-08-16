#!/bin/bash

# 🏔️ ix - Helix Hub Control Panel Global Launcher
# Swiss-Precision Access from Anywhere
# Created: August 16, 2025

# Define the project directory
HELIX_PROJECT_DIR="/home/angel/helix-hub"
CONTROL_PANEL_SCRIPT="$HELIX_PROJECT_DIR/scripts/helix-control-panel.sh"

# Check if project directory exists
if [[ ! -d "$HELIX_PROJECT_DIR" ]]; then
    echo "❌ Error: Helix Hub project directory not found at $HELIX_PROJECT_DIR"
    echo "Please update the HELIX_PROJECT_DIR variable in this script."
    exit 1
fi

# Check if control panel script exists
if [[ ! -f "$CONTROL_PANEL_SCRIPT" ]]; then
    echo "❌ Error: Helix Control Panel script not found at $CONTROL_PANEL_SCRIPT"
    echo "Please ensure the script exists and is executable."
    exit 1
fi

# Store current directory
ORIGINAL_DIR="$(pwd)"

# Change to project directory and run the control panel
cd "$HELIX_PROJECT_DIR" || {
    echo "❌ Error: Cannot change to project directory $HELIX_PROJECT_DIR"
    exit 1
}

# Make sure the script is executable
chmod +x "$CONTROL_PANEL_SCRIPT"

# Show where we're launching from if not already in the project dir
if [[ "$ORIGINAL_DIR" != "$HELIX_PROJECT_DIR" ]]; then
    echo "🏔️ Launching Helix Hub Control Panel..."
    echo "📁 Project: $HELIX_PROJECT_DIR"
    echo "🚀 Starting in 2 seconds..."
    sleep 2
fi

# Run the control panel
exec "$CONTROL_PANEL_SCRIPT" "$@"
