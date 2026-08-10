#!/usr/bin/env bash

case "$1" in
  up)
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
    ;;
  down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    ;;
  mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
  mic-mute)
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    ;;
esac

if [ "$1" = "mic-mute" ]; then
  mic_status=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null)
  if echo "$mic_status" | grep -q "MUTED"; then
    kiku-osd -i microphone-muted -m "Muted" 2>/dev/null || notify-send -h string:x-canonical-private-synchronous:mic -u low -i microphone-sensitivity-muted "Microphone" "Muted"
  else
    kiku-osd -i microphone -m "Unmuted" 2>/dev/null || notify-send -h string:x-canonical-private-synchronous:mic -u low -i audio-input-microphone "Microphone" "Unmuted"
  fi
else
  sink_status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
  if echo "$sink_status" | grep -q "MUTED"; then
    kiku-osd -i volume-muted -m "Muted" 2>/dev/null || notify-send -h string:x-canonical-private-synchronous:volume -h int:value:0 -u low -i audio-volume-muted "Volume" "Muted"
  else
    vol=$(echo "$sink_status" | awk '{print int($2 * 100)}')
    kiku-osd -i volume -p "$vol" 2>/dev/null || notify-send -h string:x-canonical-private-synchronous:volume -h int:value:"$vol" -u low "Volume" "${vol}%"
  fi
fi
