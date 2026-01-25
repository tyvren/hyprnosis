pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  readonly property string homeDir: Quickshell.env("HOME")
  readonly property string modulePath: homeDir + "/.config/hyprnosis/modules/style"
  readonly property string configPath: Quickshell.shellDir + "/config.json"
  readonly property alias data: adapter

  Process {
    id: syncFromHypr
    command: [root.modulePath + "/qs_source_hypr.sh"]
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
    }

    onLoaded: console.log("Config loaded from: " + root.configPath)
  }

  Component.onCompleted: {
    stateFileView.reload()
  }

  function updateTheme(themeId, scriptName) {
    adapter.theme = themeId
    if (scriptName) {
      Quickshell.execDetached([root.modulePath + "/theme_changer.sh", scriptName])
    }
  }

  function updateWallpaper(path) {
    adapter.wallpaper = path
  }
}
