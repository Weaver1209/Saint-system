#!/usr/bin/env bash

# Unified Clipboard Manager using cliphist, wl-clipboard, rofi, and hyprland

CLIPHIST_BIN="${CLIPHIST_BIN:-$HOME/.local/bin/cliphist}"
if ! command -v "$CLIPHIST_BIN" &>/dev/null; then
    if command -v cliphist &>/dev/null; then
        CLIPHIST_BIN="cliphist"
    fi
fi

start_daemon() {
    # Kill any existing daemon instances for clean start
    pkill -f "wl-paste --watch.*cliphist" 2>/dev/null || true
    pkill -f "wl-paste --type text --watch.*cliphist" 2>/dev/null || true
    pkill -f "wl-paste --type image --watch.*cliphist" 2>/dev/null || true

    # Start text and image watchers
    wl-paste --type text --watch "$CLIPHIST_BIN" store >/dev/null 2>&1 &
    wl-paste --type image --watch "$CLIPHIST_BIN" store >/dev/null 2>&1 &
}

pick_history() {
    if ! command -v "$CLIPHIST_BIN" &>/dev/null; then
        notify-send -u critical "Clipboard Manager" "cliphist binary not found!"
        exit 1
    fi

    # Read clipboard history
    local items
    items=$("$CLIPHIST_BIN" list 2>/dev/null)
    if [[ -z "$items" ]]; then
        notify-send -a "Clipboard" -i edit-copy -t 2000 "Clipboard History" "Clipboard is currently empty."
        exit 0
    fi

    # Display rofi picker
    # Keybinds:
    #   Enter: Copy and Auto-paste into active window
    #   Alt+c (kb-custom-1): Copy to clipboard ONLY (no auto-paste)
    #   Alt+Delete / Shift+Delete (kb-custom-2): Delete selected item from history
    #   Alt+w (kb-custom-3): Wipe all clipboard history
    local chosen rofi_exit
    chosen=$(echo "$items" | rofi -dmenu -i \
        -p "󰅌 Clipboard" \
        -mesg "<b>Enter:</b> Copy & Paste  |  <b>Alt+C:</b> Copy only  |  <b>Alt+Del:</b> Delete  |  <b>Alt+W:</b> Clear all" \
        -theme-str 'window {width: 720px;} listview {lines: 10;}' \
        -kb-custom-1 "Alt+c,Control+c" \
        -kb-custom-2 "Alt+Delete,Shift+Delete,Alt+d" \
        -kb-custom-3 "Alt+w,Alt+x")
    rofi_exit=$?

    if [[ -z "$chosen" ]]; then
        exit 0
    fi

    case $rofi_exit in
        0)
            # Enter -> Copy and auto-paste
            echo "$chosen" | "$CLIPHIST_BIN" decode | wl-copy
            sleep 0.12
            hyprctl dispatch sendshortcut "SHIFT,Insert,active" >/dev/null 2>&1 || true
            ;;
        10)
            # Alt+C / kb-custom-1 -> Copy only
            echo "$chosen" | "$CLIPHIST_BIN" decode | wl-copy
            notify-send -a "Clipboard" -i edit-copy -t 1500 "Clipboard" "Copied item to clipboard"
            ;;
        11)
            # Alt+Del / kb-custom-2 -> Delete selected item
            echo "$chosen" | "$CLIPHIST_BIN" delete
            notify-send -a "Clipboard" -i edit-delete -t 1500 "Clipboard" "Deleted item from history"
            ;;
        12)
            # Alt+W / kb-custom-3 -> Wipe all history
            local confirm
            confirm=$(printf "No\nYes, clear all history" | rofi -dmenu -i -p "󰅌 Clear entire history?" -theme-str 'window {width: 350px;} listview {lines: 2;}')
            if [[ "$confirm" =~ "Yes" ]]; then
                "$CLIPHIST_BIN" wipe
                notify-send -a "Clipboard" -i edit-clear -t 1500 "Clipboard" "All clipboard history cleared"
            fi
            ;;
    esac
}

case "${1:-pick}" in
    daemon)
        start_daemon
        ;;
    pick)
        pick_history
        ;;
    clear|wipe)
        "$CLIPHIST_BIN" wipe
        notify-send -a "Clipboard" -i edit-clear -t 1500 "Clipboard" "Clipboard history wiped"
        ;;
    *)
        pick_history
        ;;
esac
