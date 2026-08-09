#!/usr/bin/env bash

case "$1" in
  play-pause)
    playerctl play-pause
    ;;
  next)
    playerctl next
    ;;
  prev)
    playerctl previous
    ;;
  stop)
    playerctl stop
    ;;
esac

sleep 0.1

status=$(playerctl status 2>/dev/null)
if [ -n "$status" ]; then
  title=$(playerctl metadata --format '{{title}}' 2>/dev/null)
  artist=$(playerctl metadata --format '{{artist}}' 2>/dev/null)
  
  if [ -n "$artist" ] && [ -n "$title" ]; then
    msg="${title} - ${artist}"
  elif [ -n "$title" ]; then
    msg="${title}"
  else
    msg="${status}"
  fi
  
  icon="media-playback-start"
  if [ "$status" = "Paused" ]; then
    icon="media-playback-pause"
  elif [ "$status" = "Stopped" ]; then
    icon="media-playback-stop"
  fi
  
  notify-send -h string:x-canonical-private-synchronous:media -u low -i "$icon" "Media: ${status}" "${msg}"
fi
