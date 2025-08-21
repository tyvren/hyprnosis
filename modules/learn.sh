menu() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | walker --dmenu -H -p "$prompt…"
}

main_items="  Arch Wiki\n  Hyprland Wiki\n  Hyprnosis Wiki\n  Waybar Wiki"

selection=$(menu "Launcher" "$main_items")

case "$selection" in
    "  Arch Wiki")
        firefox https://wiki.archlinux.org/title/Main_page &
        ;;
    "  Hyprland Wiki")
        firefox https://wiki.hypr.land/ &
        ;;
    "  Hyprnosis Wiki")
	firefox https://github.com/steve-conrad/hyprnosis/wiki &
	;;
    "  Waybar Wiki")
	firefox https://github.com/Alexays/Waybar/wiki &
	;;
esac
