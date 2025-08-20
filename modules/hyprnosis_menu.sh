items="  Power Menu\n  Update\nKeybinds"
output=$(echo -e $items | walker --dmenu -H)
if [[ "$output" == "  Power Menu" ]]; then
	exec ~/hyprnosis/modules/power_walker.sh
elif [[ "$output" == "  Update" ]]; then
	exec ~/hyprnosis/modules/hyprnosis_update.sh	
elif [[ "$output" == "Keybinds" ]]; then
	exec ~/hyprnosis/modules/wofi_keybinds.sh	
else
	echo "Please select a command"
fi
