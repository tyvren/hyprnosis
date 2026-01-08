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
    
    watchChanges: true
    onFileChanged: reload()

    onAdapterUpdated: writeAdapter()

    JsonAdapter {
      id: adapter
      property string theme: "hyprnosis"
      property string wallpaper: ""
    }

    onLoaded: console.log("Config loaded from: " + root.configPath)
  }

  function updateTheme(themeId, scriptName) {
    adapter.theme = themeId
    
    if (scriptName) {
      Quickshell.execDetached(["/home/tyvren/.config/hyprnosis/modules/style/theme_changer.sh", scriptName])
    }
  }

  function updateWallpaper(path) {
    adapter.wallpaper = path
  }
}
