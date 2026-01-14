import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import qs.Themes
import qs.Components

PanelWindow {
  id: mainmenu
  visible: false
  focusable: true
  color: "transparent"
  property int currentIndex: 0

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }

  onVisibleChanged: {
    if (visible) {
      currentIndex = 0
      Qt.callLater(() => menuroot.forceActiveFocus())
    }
  }

  IpcHandler {
    target: "mainmenu"
    function toggle(): void { mainmenu.visible = !mainmenu.visible }
    function hide(): void { mainmenu.visible = false }
  }

  RectangularShadow {
    anchors.centerIn: parent
    width: 400
    height: 500
    blur: 10
    spread: 0
    radius: 10
    color: "transparent"
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

    Keys.onEscapePressed: mainmenu.visible = false
    Keys.onUpPressed: currentIndex = (currentIndex - 1 + menulist.count) % menulist.count
    Keys.onDownPressed: currentIndex = (currentIndex + 1) % menulist.count
    Keys.onReturnPressed: menulist.activate(currentIndex)
    Keys.onEnterPressed: menulist.activate(currentIndex)

    ColumnLayout {
      id: menulist
      anchors.centerIn: parent
      spacing: 8
      property int count: 6

      function activate(i) {
        [button1proc, button2proc, button3proc, button4proc, button5proc, button6proc][i].startDetached()
        mainmenu.visible = false
      }

      QuickMenuButton {
        id: button1
        icon: ""
        text: "Apps"
        isActive: currentIndex === 0
        onEntered: currentIndex = 0
        onClicked: menulist.activate(0)
        Process { id: button1proc; command: ["sh", "-c", "qs ipc call launcher-menu toggle"] }
      }

      QuickMenuButton {
        id: button2
        icon: ""
        text: "Packages"
        isActive: currentIndex === 1
        onEntered: currentIndex = 1
        onClicked: menulist.activate(1)
        Process { id: button2proc; command: ["sh", "-c", "qs ipc call packagesmenu toggle"] }
      }

      QuickMenuButton {
        id: button3
        icon: ""
        text: "Style"
        isActive: currentIndex === 2
        onEntered: currentIndex = 2
        onClicked: menulist.activate(2)
        Process { id: button3proc; command: ["sh", "-c", "qs ipc call stylemenu toggle"] }
      }

      QuickMenuButton {
        id: button4
        icon: "󰹑"
        text: "Capture"
        isActive: currentIndex === 3
        onEntered: currentIndex = 3
        onClicked: menulist.activate(3)
        Process { id: button4proc; command: ["sh", "-c", "qs ipc call capturemenu toggle"] }
      }

      QuickMenuButton {
        id: button5
        icon: ""
        text: "Update"
        isActive: currentIndex === 4
        onEntered: currentIndex = 4
        onClicked: menulist.activate(4)
        Process { id: button5proc; command: ["sh", "-c", "qs ipc call updatemenu toggle"] }
      }

      QuickMenuButton {
        id: button6
        icon: ""
        text: "Utilities"
        isActive: currentIndex === 5
        onEntered: currentIndex = 5
        onClicked: menulist.activate(5)
        Process { id: button6proc; command: ["sh", "-c", "qs ipc call utilmenu toggle"] }
      }
    }
  }
}
