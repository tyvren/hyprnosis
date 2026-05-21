-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -- hypridle")
	hl.exec_cmd("uwsm app -- qs")
	hl.exec_cmd("bash -c 'sleep 0.5 && uwsm app -- qs ipc call lockscreen lock'")
end)
