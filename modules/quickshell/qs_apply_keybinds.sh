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

CONF_FILE="$HOME/.config/hypr/settings/keybinds.lua"

sed -i "s/local mainMod = .*/local mainMod = \"$MOD\"/" "$CONF_FILE"

sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*hl.dsp.exec_cmd(terminal)\)/\1$TERM\2/" "$CONF_FILE"
sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*hl.dsp.exec_cmd(fileManager)\)/\1$FM\2/" "$CONF_FILE"
sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*hl.dsp.exec_cmd(menu)\)/\1$MENU\2/" "$CONF_FILE"

sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*hl.dsp.window.close()\)/\1$KILL\2/" "$CONF_FILE"
sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*hl.dsp.window.float({ action = \"toggle\" })\)/\1$FLOAT\2/" "$CONF_FILE"
sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*hl.dsp.layout(\"togglesplit\")\)/\1$SPLIT\2/" "$CONF_FILE"
sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*hl.dsp.window.pseudo()\)/\1$PSDO\2/" "$CONF_FILE"

sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*direction = \"left\"\)/\1$FL\2/" "$CONF_FILE"
sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*direction = \"right\"\)/\1$FR\2/" "$CONF_FILE"
sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*direction = \"up\"\)/\1$FU\2/" "$CONF_FILE"
sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*direction = \"down\"\)/\1$FD\2/" "$CONF_FILE"

sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*hyprlock\)/\1$LOCK\2/" "$CONF_FILE"
sed -i "s/\(\" \+ \)[^\"]*\(.*hyprshot\)/\1$SHOT\2/" "$CONF_FILE"
sed -i "s/\(mainMod .. \" + SHIFT + \)[^\"]*\(.*hypridle &\)/\1$EIDL\2/" "$CONF_FILE"
sed -i "s/\(mainMod .. \" + \)[^\"]*\(.*pkill hypridle\)/\1$DIDL\2/" "$CONF_FILE"

hyprctl reload
