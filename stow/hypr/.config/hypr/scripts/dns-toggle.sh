#!/usr/bin/env bash
# Hyprland / Waybar DNS Toggle integration script
# Delegates to kiku-dns for system DNS management

exec kiku-dns "$@"
