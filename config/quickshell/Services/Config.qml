pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string homeDir: Quickshell.env("HOME")
    readonly property string scriptPath: homeDir + "/.config/hyprnosis/modules/quickshell"
    readonly property string themeScript: homeDir + "/.config/hyprnosis/modules/style"
    readonly property string configPath: Quickshell.shellDir + "/config.json"
    readonly property alias data: adapter

    Process {
        id: syncFromHypr
        command: [root.scriptPath + "/qs_source_hypr.sh"]
        running: true 
    }

    FileView {
        id: stateFileView
        path: root.configPath
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: adapter
            property string theme: "hyprnosis"
            property string wallpaper: ""

            property string gapsIn: ""
            property string gapsOut: ""
            property string borderSize: ""
            property string rounding: ""
            property string activeOpacity: ""
            property string inactiveOpacity: ""
            property string allowTearing: ""
            property string shadowEnabled: ""
            property string blurEnabled: ""
            property string blurSize: ""
            property string blurPasses: ""
            property string disableHyprlandLogo: ""
            property string forceDefaultWallpaper: ""

            property string mainMod: ""
            property string terminal: ""
            property string fileManager: ""
            property string appLauncher: ""
            property string killActive: ""
            property string toggleFloating: ""
            property string toggleSplit: ""
            property string pseudo: "" 
            property string lockScreen: ""
            property string screenshot: ""
            property string enableIdle: ""
            property string disableIdle: ""

            property string focusLeft: ""
            property string focusRight: ""
            property string focusUp: ""
            property string focusDown: ""
        }

        onLoaded: console.log("Config loaded from: " + root.configPath)
    }

    Component.onCompleted: {
        stateFileView.reload()
    }

    function updateTheme(themeId, scriptName) {
        adapter.theme = themeId
        if (scriptName) {
            Quickshell.execDetached([root.themeScript + "/theme_changer.sh", scriptName])
        }
    }

    function updateWallpaper(path) {
        adapter.wallpaper = path
    }
}
