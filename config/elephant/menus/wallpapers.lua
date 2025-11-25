Name = "wallpapers"
NamePretty = "Wallpapers"

function GetEntries()
	local entries = {}
	local wall_dir = os.getenv("HOME") .. "/.config/hyprnosis/wallpapers/Mocha"

	local handle = io.popen("find '" ..
    wall_dir ..
    "' -maxdepth 1 -type f -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.gif' -o -name '*.bmp' -o -name '*.webp' 2>/dev/null")

	if handle then
		for wall_path in handle:lines() do
			local wall_name = wall_path:match("([^/]+)$")
			if wall_name then
				table.insert(entries, {
					Text = wall_name,
					Preview = wall_path,
					PreviewType = "file",
					Actions = {
						activate = "~/.config/hyprnosis/modules/style/wallpaper_changer.sh " .. wall_path,
					},
				})
			end
		end
		handle:close()
	end

	return entries
end
