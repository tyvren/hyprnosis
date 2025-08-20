menu() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | walker --dmenu -H -p "$prompt…"
}

main_items="  Arch Wiki\n  Hyprland Wiki"

selection=$(menu "Launcher" "$main_items")

case "$selection" in
    "  Arch Wiki")
        firefox https://wiki.archlinux.org/title/Main_page &
        ;;
    "  Hyprland Wiki")
        firefox https://hypr.land/ &
        ;;
esac

