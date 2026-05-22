#!/usr/bin/env bash

WALLPAPER_PATH="$1"

if [ -n "$WALLPAPER_PATH" ]; then
  echo "$WALLPAPER_PATH" >"$STATE_FILE"

  notify-send "Wallpaper Updated" "$WALLPAPER_PATH"
else
  notify-send "Wallpaper Error" "No path provided to script."
fi
