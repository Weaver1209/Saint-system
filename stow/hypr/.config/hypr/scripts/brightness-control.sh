#!/usr/bin/env bash

case "$1" in
  up)
    brightnessctl set +5%
    ;;
  down)
    brightnessctl set 5%-
    ;;
esac

bright=$(brightnessctl -m | cut -d',' -f4 | tr -d '%')
omarchy-osd -i brightness -p "$bright" 2>/dev/null || notify-send -h string:x-canonical-private-synchronous:brightness -h int:value:"$bright" -u low -i display-brightness "Brightness" "${bright}%"
