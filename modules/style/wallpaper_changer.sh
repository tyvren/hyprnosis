#!/usr/bin/env bash

# Use the first argument as the path
WALLPAPER_PATH="$1"
STATE_DIR="$HOME/.config/hyprnosis"
STATE_FILE="$STATE_DIR/.current_wallpaper"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"

# Ensure directory exists
mkdir -p "$STATE_DIR"

# Only write to the file if a path was actually provided
if [ -n "$WALLPAPER_PATH" ]; then
  echo "$WALLPAPER_PATH" >"$STATE_FILE"

  # Update hyprlock config if it exists
  if [ -f "$HYPRLOCK_CONF" ]; then
    # Use | as a delimiter in sed so we don't clash with / in file paths
    sed -i "/background {/,/}/{s|path = .*|path = $WALLPAPER_PATH|}" "$HYPRLOCK_CONF"
  fi

  notify-send "Wallpaper Updated" "$WALLPAPER_PATH"
else
  notify-send "Wallpaper Error" "No path provided to script."
fi
