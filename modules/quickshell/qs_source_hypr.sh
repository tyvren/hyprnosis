#!/bin/bash

WAWCONF="$HOME/.config/hypr/settings/windows-and-workspaces.conf"
KEYCONF="$HOME/.config/hypr/settings/keybinds.conf"
JSON="$HOME/.config/quickshell/config.json"

get_conf() {
  grep -P "^\s*$1\s*=" "$WAWCONF" | awk -F'[=#]' '{print $2}' | xargs | head -n 1
}

get_blur() {
  sed -n '/blur {/,/}/p' "$WAWCONF" | grep -P "^\s*$1\s*=" | awk -F'[=#]' '{print $2}' | xargs
}

get_shadow() {
  sed -n '/shadow {/,/}/p' "$WAWCONF" | grep -P "^\s*$1\s*=" | awk -F'[=#]' '{print $2}' | xargs
}

get_misc() {
  sed -n '/misc {/,/}/p' "$WAWCONF" | grep -P "^\s*$1\s*=" | awk -F'[=#]' '{print $2}' | xargs
}

get_mod() {
  grep -P "^\s*\\\$mainMod\s*=" "$KEYCONF" | awk -F'=' '{print $2}' | xargs | head -n 1
}

get_key() {
  grep -i "$1" "$KEYCONF" | head -n 1 | awk -F',' '{print $2}' | xargs
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

MOD=$(get_mod)
TERM=$(get_key "\\\$terminal")
FM=$(get_key "\\\$fileManager")
MENU=$(get_key "\\\$menu")
KILL=$(get_key "killactive")
FLOAT=$(get_key "togglefloating")
SPLIT=$(get_key "togglesplit")
PSDO=$(get_key "pseudo")
LOCK=$(get_key "hyprlock")
SHOT=$(get_key "hyprshot")
EIDL=$(get_key "hypridle &")
DIDL=$(get_key "pkill hypridle")
FL=$(get_key "movefocus, l")
FR=$(get_key "movefocus, r")
FU=$(get_key "movefocus, u")
FD=$(get_key "movefocus, d")

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
