#!/usr/bin/env bash

# Power menu — prefer wlogout, fall back to rofi
if command -v wlogout >/dev/null 2>&1; then
  wlogout
else
  CHOSEN=$(printf "󰌾 Lock\n󰍃 Logout\n󰤄 Suspend\n󰜉 Reboot\n󰐥 Power Off" | rofi -dmenu -i -p "Power Menu" -theme-str 'window {width: 250px;}')

  case "$CHOSEN" in
    *Lock)
      if command -v hyprlock >/dev/null 2>&1; then
        hyprlock
      elif command -v swaylock >/dev/null 2>&1; then
        swaylock
      elif command -v loginctl >/dev/null 2>&1; then
        loginctl lock-session
      fi
      ;;
    *Logout)
      hyprctl dispatch exit 0
      ;;
    *Suspend)
      systemctl suspend
      ;;
    *Reboot)
      systemctl reboot
      ;;
    *"Power Off")
      systemctl poweroff
      ;;
  esac
fi
