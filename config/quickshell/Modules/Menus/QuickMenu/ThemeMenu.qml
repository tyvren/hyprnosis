import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import qs.Services
import qs.Themes
import qs.Components

PanelWindow {
  id: thememenu
  visible: false
  focusable: true
  color: "transparent"
  property int currentIndex: 0

  anchors.top: true
  anchors.bottom: true
  anchors.left: true
  anchors.right: true

  onVisibleChanged: {
    if (visible) {
      currentIndex = 0
      Qt.callLater(() => menuroot.forceActiveFocus())
    }
  }

  IpcHandler {
    target: "thememenu"
    function toggle(): void { thememenu.visible = !thememenu.visible }
    function hide(): void { thememenu.visible = false }
  }

  Rectangle {
    id: menuroot
    anchors.centerIn: parent
    width: 400
    height: 500
    radius: 10
    color: "transparent"
    
    Image {
      id: logoImage
      anchors.centerIn: parent
      width: 500
      height: 500
      source: Theme.logoPath
      mipmap: true
      asynchronous: true
      fillMode: Image.PreserveAspectFit
      opacity: 0.7
    }

    Keys.onEscapePressed: thememenu.visible = false
    Keys.onUpPressed: currentIndex = (currentIndex - 1 + themelist.count) % themelist.count
    Keys.onDownPressed: currentIndex = (currentIndex + 1) % themelist.count
    Keys.onReturnPressed: themelist.activate(currentIndex)
    Keys.onEnterPressed: themelist.activate(currentIndex)

    ColumnLayout {
      id: themelist
      anchors.centerIn: parent
      spacing: 8
      property int count: 6

      function activate(index) {
        let themeData = [
          { id: "hyprnosis",  script: "Hyprnosis" },
          { id: "mocha",      script: "Mocha" },
          { id: "emberforge", script: "Emberforge" },
          { id: "dracula",    script: "Dracula" },
          { id: "arcadia",    script: "Arcadia" },
          { id: "eden",       script: "Eden" }
        ][index]

        Config.updateTheme(themeData.id, themeData.script)
        Config.updateWallpaper("")
        thememenu.visible = false
      }

      component ThemeButton : QuickMenuButton {
        property int index: 0
        isActive: currentIndex === index
        onEntered: currentIndex = index
        onClicked: themelist.activate(index)
      }

      ThemeButton { index: 0; text: "Hyprnosis" }
      ThemeButton { index: 1; text: "Catppuccin Mocha" }
      ThemeButton { index: 2; text: "Emberforge" }
      ThemeButton { index: 3; text: "Dracula" }
      ThemeButton { index: 4; text: "Arcadia" }
      ThemeButton { index: 5; text: "Eden" }
    }
  }
}
