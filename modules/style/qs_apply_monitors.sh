#!/bin/bash

NAME=$1
RES=$2
POS=$3
SCALE=$4
GDK=$5

CONF_FILE="$HOME/.config/hypr/monitors.conf"

if grep -q "monitor=$NAME," "$CONF_FILE"; then
  sed -i "s|^monitor=$NAME,.*|monitor=$NAME,$RES,$POS,$SCALE|" "$CONF_FILE"
else
  sed -i "/### MONITORS ###/a monitor=$NAME,$RES,$POS,$SCALE" "$CONF_FILE"
fi

sed -i "s|^env = GDK_SCALE,.*|env = GDK_SCALE,$GDK|" "$CONF_FILE"

hyprctl keyword monitor "$NAME,$RES,$POS,$SCALE"
