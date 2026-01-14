import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Themes
import qs.Components

PanelWindow {
  id: capturemenu
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
    target: "capturemenu"

    function toggle(): void {
      capturemenu.visible = !capturemenu.visible
    }

    function hide(): void {
      capturemenu.visible = false
    }
  }

  RectangularShadow {
    anchors.centerIn: parent
    width: 400
    height: 300
    blur: 10
    spread: 0
    radius: 10
    color: "transparent" 
  }

  Rectangle {
    id: menuroot
    anchors.centerIn: parent
    width: 400
    height: 300
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

    Keys.onEscapePressed: capturemenu.visible = false
    Keys.onUpPressed: currentIndex = (currentIndex - 1 + menulist.count) % menulist.count
    Keys.onDownPressed: currentIndex = (currentIndex + 1) % menulist.count
    Keys.onReturnPressed: menulist.activate(currentIndex)
    Keys.onEnterPressed: menulist.activate(currentIndex)

    ColumnLayout {
      id: menulist
      anchors.centerIn: parent
      spacing: 8
      property int count: 3

      function activate(index) {
        switch (index) {
          case 0: button1proc.startDetached(); break
          case 1: button2proc.startDetached(); break
          case 2: button3proc.startDetached(); break
        }
        capturemenu.visible = false
      }

      QuickMenuButton {
        id: button1
        icon: "󰹑"
        text: "Region"
        isActive: currentIndex === 0
        onEntered: currentIndex = 0
        onClicked: {
          currentIndex = 0
          button1proc.startDetached()
          capturemenu.visible = false
        }
        Process {
          id: button1proc
          command: ["hyprshot", "-m", "region"]
        }
      }

      QuickMenuButton {
        id: button2
        icon: "󰹑"
        text: "Window"
        isActive: currentIndex === 1
        onEntered: currentIndex = 1
        onClicked: {
          currentIndex = 1
          button2proc.startDetached()
          capturemenu.visible = false
        }
        Process {
          id: button2proc
          command: ["hyprshot", "-m", "window"]
        }
      }

      QuickMenuButton {
        id: button3
        icon: ""
        text: "Record"
        isActive: currentIndex === 2
        onEntered: currentIndex = 2
        onClicked: {
          currentIndex = 2
          button3proc.startDetached()
          capturemenu.visible = false
        }
        Process {
          id: button3proc
          command: ["obs", "--startrecording"]
        }
      }
    }
  }
}
