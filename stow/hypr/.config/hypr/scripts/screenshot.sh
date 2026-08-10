#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILENAME="$DIR/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"

case "$1" in
    full)
        grim "$FILENAME" && wl-copy < "$FILENAME"
        notify-send -i "$FILENAME" "Screenshot Captured" "Fullscreen saved to Screenshots & copied to clipboard"
        ;;
    full-clip)
        grim - | wl-copy --type image/png
        notify-send "Screenshot Captured" "Fullscreen copied to clipboard"
        ;;
    region)
        REGION=$(slurp)
        if [ -n "$REGION" ]; then
            grim -g "$REGION" "$FILENAME" && wl-copy < "$FILENAME"
            notify-send -i "$FILENAME" "Screenshot Captured" "Region saved to Screenshots & copied to clipboard"
        fi
        ;;
    region-clip)
        REGION=$(slurp)
        if [ -n "$REGION" ]; then
            grim -g "$REGION" - | wl-copy --type image/png
            notify-send "Screenshot Captured" "Region copied to clipboard"
        fi
        ;;
    *)
        echo "Usage: $0 {full|full-clip|region|region-clip}"
        exit 1
        ;;
esac
