#!/usr/bin/env bash

WALLPAPER_PATH="$1"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"

if [ -n "$WALLPAPER_PATH" ]; then
  echo "$WALLPAPER_PATH" >"$STATE_FILE"

  if [ -f "$HYPRLOCK_CONF" ]; then
    sed -i "/background {/,/}/{s|path = .*|path = $WALLPAPER_PATH|}" "$HYPRLOCK_CONF"
  fi

  notify-send "Wallpaper Updated" "$WALLPAPER_PATH"
else
  notify-send "Wallpaper Error" "No path provided to script."
fi
