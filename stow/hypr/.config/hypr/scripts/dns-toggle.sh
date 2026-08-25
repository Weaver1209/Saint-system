#!/usr/bin/env bash
# Hyprland / Waybar DNS Toggle integration script
# Delegates to kiku-dns for system DNS management

export PATH="$HOME/.local/bin:$PATH"

if command -v kiku-dns &>/dev/null; then
  exec kiku-dns "$@"
elif [ -x "$HOME/.local/bin/kiku-dns" ]; then
  exec "$HOME/.local/bin/kiku-dns" "$@"
else
  echo "kiku-dns not found" >&2
  exit 1
fi
