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

  function performSave() {
    try {
      stateFileView.writeAdapter()
    } catch (e) {
      console.log("Save failed: " + e)
    }
  }

  function updateTheme(themeId, scriptName) {
    adapter.theme = themeId
    
    if (scriptName) {
      Quickshell.execDetached(["sh", "-c", `~/.config/hyprnosis/modules/style/theme_changer.sh "${scriptName}"`])
    }

    performSave()
  }

  function updateWallpaper(path) {
    adapter.wallpaper = path
    performSave()
  }
}
