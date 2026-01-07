pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string configPath: Quickshell.shellDir + "/state.json"
    readonly property alias data: adapter

    FileView {
        id: stateFileView
        path: root.configPath
        printErrors: true

        adapter: JsonAdapter {
            id: adapter
            property string theme: "hyprnosis"
            property string wallpaper: ""
        }

        onLoaded: console.log("Config loaded from: " + root.configPath)
    }

    Timer {
        id: saveTimer
        interval: 10
        onTriggered: performSave()
    }

    Timer {
        id: scriptTimer
        interval: 50
        property string scriptArg: ""
        onTriggered: {
            Quickshell.execDetached(["sh", "-c", `~/.config/hyprnosis/modules/style/theme_changer.sh "${scriptArg}"`])
        }
    }

    function save() {
        saveTimer.restart()
    }

    function performSave() {
        try {
            stateFileView.writeAdapter()
            console.log("Config saved to disk.")
        } catch (e) {
            console.log("Save failed: " + e)
        }
    }

    function updateTheme(themeId, scriptName) {
        adapter.theme = themeId
        save()
        
        if (scriptName) {
            scriptTimer.scriptArg = scriptName
            scriptTimer.restart()
        }
    }

    function updateWallpaper(path) {
        adapter.wallpaper = path
        save()
    }
}
