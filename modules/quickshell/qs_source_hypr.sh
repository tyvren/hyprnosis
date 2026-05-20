#!/bin/bash

# Updated file paths
LOOK_FEEL="$HOME/.config/hypr/settings/look-and-feel.lua"
KEYBIND_LUA="$HOME/.config/hypr/settings/keybinds.lua"
JSON="$HOME/.config/quickshell/config.json"

get_look() {
  grep -P "^\s*$1\s*=" "$LOOK_FEEL" | awk -F'[=,]' '{print $2}' | xargs | head -n 1
}

get_blur() {
  sed -n '/blur = {/,/}/p' "$LOOK_FEEL" | grep -P "^\s*$1\s*=" | awk -F'[=,]' '{print $2}' | xargs
}

get_shadow() {
  sed -n '/shadow = {/,/}/p' "$LOOK_FEEL" | grep -P "^\s*$1\s*=" | awk -F'[=,]' '{print $2}' | xargs
}

get_misc() {
  sed -n '/misc = {/,/}/p' "$LOOK_FEEL" | grep -P "^\s*$1\s*=" | awk -F'[=,]' '{print $2}' | xargs
}

get_var() {
  grep -P "local $1\s*=" "$KEYBIND_LUA" | awk -F'"' '{print $2}' | xargs
}

get_bind() {
    local line
    line=$(grep -P "hl\.bind.*$1" "$KEYBIND_LUA" | head -n 1)
    if [ -z "$line" ]; then
        echo ""
        return
    fi
    local key
    key=$(echo "$line" | grep -oP 'mainMod \.\. "\s*\+\s*\K[^"]+' 2>/dev/null)
    if [ -n "$key" ]; then
        echo "$key" | sed 's/^SHIFT + //'
    else
        echo "$line" | grep -oP 'hl\.bind\("\K[^"]+' | xargs
    fi
}

GI=$(get_look "gaps_in")
GO=$(get_look "gaps_out")
BS=$(get_look "border_size")
RN=$(get_look "rounding")
AO=$(get_look "active_opacity")
IO=$(get_look "inactive_opacity")
TR=$(get_look "allow_tearing")
SH=$(get_shadow "enabled")
BE=$(get_blur "enabled")
BSZ=$(get_blur "size")
BPS=$(get_blur "passes")
LG=$(get_misc "disable_hyprland_logo")
FW=$(get_misc "force_default_wallpaper")

MOD=$(get_var "mainMod")
TERM=$(get_bind "terminal")
FM=$(get_bind "fileManager")
MENU=$(get_bind "menu")

KILL=$(get_bind "window\.close")
FLOAT=$(get_bind "window\.float")
SPLIT=$(get_bind "layout")
PSDO=$(get_bind "window\.pseudo")

FL=$(get_bind "direction = \"left\"")
FR=$(get_bind "direction = \"right\"")
FU=$(get_bind "direction = \"up\"")
FD=$(get_bind "direction = \"down\"")

LOCK=$(get_bind "hyprlock")
SHOT=$(get_bind "flameshot")
EIDL=$(get_bind "hypridle &")
DIDL=$(get_bind "pkill hypridle")

jq --arg gi "$GI" --arg go "$GO" --arg bs "$BS" --arg rn "$RN" \
  --arg ao "$AO" --arg io "$IO" --arg tr "$TR" --arg sh "$SH" \
  --arg be "$BE" --arg bsz "$BSZ" --arg bps "$BPS" --arg lg "$LG" \
  --arg fw "$FW" \
  --arg mod "$MOD" --arg term "$TERM" --arg fm "$FM" --arg menu "$MENU" \
  --arg kill "$KILL" --arg float "$FLOAT" --arg split "$SPLIT" \
  --arg psdo "$PSDO" --arg lock "$LOCK" --arg shot "$SHOT" \
  --arg eidl "$EIDL" --arg didl "$DIDL" --arg fl "$FL" --arg fr "$FR" \
  --arg fu "$FU" --arg fd "$FD" \
  '.gapsIn=$gi | .gapsOut=$go | .borderSize=$bs | .rounding=$rn | .activeOpacity=$ao | .inactiveOpacity=$io | .allowTearing=$tr | .shadowEnabled=$sh | .blurEnabled=$be | .blurSize=$bsz | .blurPasses=$bps | .disableHyprlandLogo=$lg | .forceDefaultWallpaper=$fw | .mainMod=$mod | .terminal=$term | .fileManager=$fm | .appLauncher=$menu | .killActive=$kill | .toggleFloating=$float | .toggleSplit=$split | .pseudo=$psdo | .lockScreen=$lock | .screenshot=$shot | .enableIdle=$eidl | .disableIdle=$didl | .focusLeft=$fl | .focusRight=$fr | .focusUp=$fu | .focusDown=$fd' \
  "$JSON" >"$JSON.tmp" && mv "$JSON.tmp" "$JSON"
