#!/bin/bash

NAME=$1
RES=$2
POS=$3
SCALE=$4
GDK=$5

CONF_FILE="$HOME/.config/hypr/settings/monitors.lua"

if grep -q "output = \"$NAME\"" "$CONF_FILE"; then
  sed -i "/output = \"$NAME\"/,/})/ s/mode = .*/mode = \"$RES\",/" "$CONF_FILE"
  sed -i "/output = \"$NAME\"/,/})/ s/position = .*/position = \"$POS\",/" "$CONF_FILE"
  sed -i "/output = \"$NAME\"/,/})/ s/scale = .*/scale = \"$SCALE\",/" "$CONF_FILE"
else
  cat <<EOF >>"$CONF_FILE"

hl.monitor({
    output = "$NAME",
    mode = "$RES",
    position = "$POS",
    scale = "$SCALE",
})
EOF
fi

sed -i "s/env = GDK_SCALE, .*/env = GDK_SCALE, $GDK,/" "$CONF_FILE"

hyprctl reload
