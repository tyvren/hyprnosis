#!/bin/bash

CONF="$HOME/.config/hypr/settings/windows-and-workspaces.conf"
JSON="$HOME/.config/quickshell/config.json"

get_conf() {
  grep -P "^\s*$1\s*=" "$CONF" | awk -F'[=#]' '{print $2}' | xargs | head -n 1
}

get_blur() {
  sed -n '/blur {/,/}/p' "$CONF" | grep -P "^\s*$1\s*=" | awk -F'[=#]' '{print $2}' | xargs
}

get_shadow() {
  sed -n '/shadow {/,/}/p' "$CONF" | grep -P "^\s*$1\s*=" | awk -F'[=#]' '{print $2}' | xargs
}

get_misc() {
  sed -n '/misc {/,/}/p' "$CONF" | grep -P "^\s*$1\s*=" | awk -F'[=#]' '{print $2}' | xargs
}

GI=$(get_conf "gaps_in")
GO=$(get_conf "gaps_out")
BS=$(get_conf "border_size")
RN=$(get_conf "rounding")
AO=$(get_conf "active_opacity")
IO=$(get_conf "inactive_opacity")
TR=$(get_conf "allow_tearing")
SH=$(get_shadow "enabled")
BE=$(get_blur "enabled")
BSZ=$(get_blur "size")
BPS=$(get_blur "passes")
LG=$(get_misc "disable_hyprland_logo")
FW=$(get_misc "force_default_wallpaper")

jq --arg gi "$GI" --arg go "$GO" --arg bs "$BS" --arg rn "$RN" \
  --arg ao "$AO" --arg io "$IO" --arg tr "$TR" --arg sh "$SH" \
  --arg be "$BE" --arg bsz "$BSZ" --arg bps "$BPS" --arg lg "$LG" \
  --arg fw "$FW" \
  '.gapsIn=$gi | .gapsOut=$go | .borderSize=$bs | .rounding=$rn | .activeOpacity=$ao | .inactiveOpacity=$io | .allowTearing=$tr | .shadowEnabled=$sh | .blurEnabled=$be | .blurSize=$bsz | .blurPasses=$bps | .disableHyprlandLogo=$lg | .forceDefaultWallpaper=$fw' \
  "$JSON" >"$JSON.tmp" && mv "$JSON.tmp" "$JSON"
