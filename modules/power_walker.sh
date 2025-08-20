items="  Shutdown\n  Restart\n Lock"
output=$(echo -e $items | walker --dmenu -H)
if [[ "$output" == "  Shutdown" ]]; then
	systemctl poweroff
elif [[ "$output" == "  Restart" ]]; then
	systemctl reboot	
elif [[ "$output" == " Lock" ]]; then
	hyprlock	
else
	echo "Please select a command"
fi
