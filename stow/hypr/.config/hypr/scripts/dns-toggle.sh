#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/dns-toggle-state"

get_state() {
  if [ -f "$STATE_FILE" ]; then
    cat "$STATE_FILE"
  else
    echo "off"
  fi
}

case "$1" in
  status)
    STATE=$(get_state)
    if [ "$STATE" = "on" ]; then
      printf '{"alt":"on","tooltip":"DNS: Secure (Cloudflare 1.1.1.1)","class":"on"}\n'
    else
      printf '{"alt":"off","tooltip":"DNS: Default (DHCP)","class":"off"}\n'
    fi
    ;;
  toggle)
    STATE=$(get_state)
    if [ "$STATE" = "on" ]; then
      echo "off" > "$STATE_FILE"
      notify-send -u low -i network-wireless "DNS Toggle" "DNS set to Default (DHCP)" 2>/dev/null || true
    else
      echo "on" > "$STATE_FILE"
      notify-send -u low -i network-wireless "DNS Toggle" "DNS set to Secure (1.1.1.1)" 2>/dev/null || true
    fi
    ;;
  *)
    get_state
    ;;
esac
