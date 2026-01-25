#!/bin/bash

GAPS_IN=$1
GAPS_OUT=$2
BORDER=$3
ROUNDING=$4
ACTIVE_OP=$5
INACTIVE_OP=$6
TEARING=$7
SHADOW=$8
BLUR=$9
BLUR_SIZE=${10}
BLUR_PASSES=${11}
LOGO=${12}
WALLPAPER=${13}

CONF_FILE="$HOME/.config/hypr/settings/windows-and-workspaces.conf"

sed -i "s/gaps_in = .*/gaps_in = $GAPS_IN/" "$CONF_FILE"
sed -i "s/gaps_out = .*/gaps_out = $GAPS_OUT/" "$CONF_FILE"
sed -i "s/border_size = .*/border_size = $BORDER/" "$CONF_FILE"
sed -i "s/allow_tearing = .*/allow_tearing = $TEARING/" "$CONF_FILE"
sed -i "s/rounding = .*/rounding = $ROUNDING/" "$CONF_FILE"
sed -i "s/active_opacity = .*/active_opacity = $ACTIVE_OP/" "$CONF_FILE"
sed -i "s/inactive_opacity = .*/inactive_opacity = $INACTIVE_OP/" "$CONF_FILE"

sed -i "/shadow {/,/}/ s/enabled = .*/enabled = $SHADOW/" "$CONF_FILE"
sed -i "/blur {/,/}/ s/enabled = .*/enabled = $BLUR/" "$CONF_FILE"
sed -i "/blur {/,/}/ s/size = .*/size = $BLUR_SIZE/" "$CONF_FILE"
sed -i "/blur {/,/}/ s/passes = .*/passes = $BLUR_PASSES/" "$CONF_FILE"

sed -i "s/disable_hyprland_logo = .*/disable_hyprland_logo = $LOGO/" "$CONF_FILE"
sed -i "s/force_default_wallpaper = .*/force_default_wallpaper = $WALLPAPER/" "$CONF_FILE"

hyprctl reload
