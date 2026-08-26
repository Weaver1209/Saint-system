#!/usr/bin/env bash

# Path to Wallpapers folder
if [ -d "$HOME/Pictures/wallpaper" ]; then
    WALLPAPER_DIR="$HOME/Pictures/wallpaper"
elif [ -d "$HOME/picture/wallpaper" ]; then
    WALLPAPER_DIR="$HOME/picture/wallpaper"
else
    WALLPAPER_DIR="$HOME/Media/Pictures/Wallpapers"
fi
CONFIG_DIR="$HOME/.config/hyprpaper"
CONFIG_FILE="$CONFIG_DIR/hyprpaper.conf"

# Ensure directories exist
mkdir -p "$WALLPAPER_DIR" "$CONFIG_DIR"

# Randomly select a photo from the Wallpapers directory
WALLPAPER=$(find "$WALLPAPER_DIR" -maxdepth 2 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null | shuf -n 1)

if [ -z "$WALLPAPER" ]; then
    echo "No wallpaper images found in $WALLPAPER_DIR"
    exit 1
fi

# Get list of connected monitors dynamically
MONITORS=$(hyprctl monitors -j 2>/dev/null | jq -r '.[].name' 2>/dev/null)
if [ -z "$MONITORS" ]; then
    MONITORS=$(hyprctl monitors 2>/dev/null | grep "^Monitor" | awk '{print $2}')
fi

# Generate hyprpaper.conf dynamically using hyprpaper v0.8+ block syntax
{
    echo "# Managed automatically by ~/.config/hyprpaper/hyprpaper.sh"
    echo "splash = false"
    echo "splash_opacity = 0"
    echo "ipc = on"
    if [ -n "$MONITORS" ]; then
        for MON in $MONITORS; do
            echo "wallpaper {"
            echo "    monitor = $MON"
            echo "    path = $WALLPAPER"
            echo "}"
        done
    else
        echo "wallpaper {"
        echo "    monitor = "
        echo "    path = $WALLPAPER"
        echo "}"
    fi
} > "$CONFIG_FILE"

# Apply dynamically via IPC if hyprpaper is running, else start daemon with config
if pgrep -x "hyprpaper" >/dev/null 2>&1 && hyprctl hyprpaper preload "$WALLPAPER" >/dev/null 2>&1; then
    if [ -n "$MONITORS" ]; then
        for MON in $MONITORS; do
            hyprctl hyprpaper wallpaper "$MON,$WALLPAPER" >/dev/null 2>&1
        done
    else
        hyprctl hyprpaper wallpaper ",$WALLPAPER" >/dev/null 2>&1
    fi
    hyprctl hyprpaper unload all >/dev/null 2>&1 || true
else
    pkill -x hyprpaper >/dev/null 2>&1 || true
    hyprpaper -c "$CONFIG_FILE" >/dev/null 2>&1 &
fi

# Automatically re-theme desktop with Aether
if [ -x "$HOME/.config/aether/bin/walt-aether" ]; then
    "$HOME/.config/aether/bin/walt-aether" "$WALLPAPER" --force >/dev/null 2>&1 &
fi

