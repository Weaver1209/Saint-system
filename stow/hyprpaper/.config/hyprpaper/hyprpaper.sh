#!/usr/bin/env bash

# Path to Wallpapers folder in Media/Pictures
WALLPAPER_DIR="$HOME/Media/Pictures/Wallpapers"
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

# Write updated hyprpaper configuration
cat << EOF > "$CONFIG_FILE"
preload = $WALLPAPER
wallpaper = ,$WALLPAPER
EOF

# Try dynamically updating wallpaper via IPC if hyprpaper is running,
# otherwise fallback to restarting hyprpaper daemon with the new config.
if pgrep -x "hyprpaper" >/dev/null 2>&1 && hyprctl hyprpaper preload "$WALLPAPER" >/dev/null 2>&1; then
    hyprctl hyprpaper wallpaper ",$WALLPAPER" >/dev/null 2>&1
    hyprctl hyprpaper unload all >/dev/null 2>&1 || true
else
    pkill -x hyprpaper >/dev/null 2>&1 || true
    hyprpaper -c "$CONFIG_FILE" >/dev/null 2>&1 &
fi
