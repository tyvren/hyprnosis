#!/bin/bash

MOD=$1
TERM=$2
FM=$3
MENU=$4
KILL=$5
FLOAT=$6
SPLIT=$7
PSDO=$8
LOCK=$9
SHOT=${10}
EIDL=${11}
DIDL=${12}
FL=${13}
FR=${14}
FU=${15}
FD=${16}

CONF_FILE="$HOME/.config/hypr/settings/keybinds.conf"

sed -i "s/^\$mainMod = .*/\$mainMod = $MOD/" "$CONF_FILE"

sed -i "s/\(bind = \$mainMod, \)[^,]*\(, exec, uwsm app -- \$terminal\)/\1$TERM\2/" "$CONF_FILE"
sed -i "s/\(bind = \$mainMod, \)[^,]*\(, exec, uwsm app -- \$fileManager\)/\1$FM\2/" "$CONF_FILE"
sed -i "s/\(bind = \$mainMod, \)[^,]*\(, exec, uwsm app -- \$menu\)/\1$MENU\2/" "$CONF_FILE"

sed -i "s/\(bind = \$mainMod, \)[^,]*\(, killactive,\)/\1$KILL\2/" "$CONF_FILE"
sed -i "s/\(bind = \$mainMod, \)[^,]*\(, togglefloating,\)/\1$FLOAT\2/" "$CONF_FILE"
sed -i "s/\(bind = \$mainMod, \)[^,]*\(, togglesplit,\)/\1$SPLIT\2/" "$CONF_FILE"
sed -i "s/\(bind = \$mainMod, \)[^,]*\(, pseudo,\)/\1$PSDO\2/" "$CONF_FILE"

sed -i "s/\(bind = \$mainMod, \)[^,]*\(, exec, uwsm app -- hyprlock\)/\1$LOCK\2/" "$CONF_FILE"
sed -i "s/\(bind = , \)[^,]*\(, exec, uwsm app -- hyprshot\)/\1$SHOT\2/" "$CONF_FILE"

sed -i "s/\(bind = \$mainMod SHIFT, \)[^,]*\(, exec, uwsm app -- hyprctl dispatch exec \"hypridle &\".*\)/\1$EIDL\2/" "$CONF_FILE"
sed -i "s/\(bind = \$mainMod, \)[^,]*\(, exec, uwsm app -- hyprctl dispatch exec \"pkill hypridle\".*\)/\1$DIDL\2/" "$CONF_FILE"

sed -i "s/\(bind = \$mainMod, \)[^,]*\(, movefocus, l\)/\1$FL\2/" "$CONF_FILE"
sed -i "s/\(bind = \$mainMod, \)[^,]*\(, movefocus, r\)/\1$FR\2/" "$CONF_FILE"
sed -i "s/\(bind = \$mainMod, \)[^,]*\(, movefocus, u\)/\1$FU\2/" "$CONF_FILE"
sed -i "s/\(bind = \$mainMod, \)[^,]*\(, movefocus, d\)/\1$FD\2/" "$CONF_FILE"

hyprctl reload
