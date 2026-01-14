import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Themes
import qs.Components

PanelWindow {
  id: utilmenu
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
      Qt.callLater(() => menuRoot.forceActiveFocus())
    }
  }

  IpcHandler {
    target: "utilmenu"
    function toggle(): void { utilmenu.visible = !utilmenu.visible }
    function hide(): void { utilmenu.visible = false }
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
    id: menuRoot
    focus: true
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

    Keys.onEscapePressed: utilmenu.visible = false
    Keys.onUpPressed: currentIndex = (currentIndex - 1 + buttonList.count) % buttonList.count
    Keys.onDownPressed: currentIndex = (currentIndex + 1) % buttonList.count
    Keys.onReturnPressed: buttonList.activate(currentIndex)
    Keys.onEnterPressed: buttonList.activate(currentIndex)

    ColumnLayout {
      id: buttonList
      anchors.centerIn: parent
      spacing: 8
      property int count: 3

      function activate(index) {
        switch(index) {
          case 0: button1.startDetached(); break
          case 1: button2.startDetached(); break
          case 2: button3.startDetached(); break
        }
        utilmenu.visible = false
      }

      component UtilButton : QuickMenuButton {
        property string fullCommand: ""
        property int index: 0
        property alias process: proc
        
        isActive: currentIndex === index
        onEntered: currentIndex = index
        onClicked: {
          currentIndex = index
          proc.startDetached()
          utilmenu.visible = false
        }

        Process {
          id: proc
          command: ["sh", "-c", `ghostty -e ${fullCommand}`]
        }
      }

      UtilButton { 
        index: 0; icon: ""; text: "Hypr Config"
        fullCommand: "~/.config/hyprnosis/modules/quickconfig/quickconfig.sh"
        id: button1 
      }
      
      UtilButton { 
        index: 1; icon: "󱊟"; text: "ISO Writer"
        fullCommand: "~/.config/hyprnosis/modules/diskmanagement/write_iso.sh"
        id: button2 
      }
      
      UtilButton { 
        index: 2; icon: "󱁋"; text: "Mount Disk"
        fullCommand: "~/.config/hyprnosis/modules/diskmanagement/mount_disk.sh"
        id: button3 
      }
    }
  }
}
