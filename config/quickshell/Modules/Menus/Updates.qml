import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import "../.."

PanelWindow {
  id: updatemenu
  visible: false
  focusable: true
  color: "transparent"
  WlrLayershell.layer: WlrLayer.Top
  property var theme: Theme {}
  property int currentIndex: 0

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }

  onVisibleChanged: {
    if (visible) Qt.callLater(() => menuRoot.forceActiveFocus())
  }

  IpcHandler {
    target: "updatemenu"

    function toggle(): void {
      updatemenu.visible = !updatemenu.visible
    }

    function hide(): void {
      updatemenu.visible = false
    }
  }

  Rectangle {
    id: menuRoot
    focus: true
    anchors.centerIn: parent
    width: 400
    height: 300
    radius: 10
    color: theme.colBg
    border.width: 2
    border.color: theme.colAccent

    Keys.onEscapePressed: updatemenu.visible = false
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
        updatemenu.visible = false
      }

      Rectangle {
        width: 350
        height: 60
        radius: 10
        color: currentIndex === 0 || button1area.containsMouse ? theme.colSelect : theme.colBg
        border.width: 2
        border.color: theme.colAccent

        Text {
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 15
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 22
          text: "Update System"
        }

        MouseArea {
          id: button1area
          anchors.fill: parent
          hoverEnabled: true
          onEntered: currentIndex = 0
          onClicked: { currentIndex = 0; button1.startDetached(); updatemenu.visible = false }
        }

        Process { id: button1; command: ["sh","-c","ghostty -e ~/.config/hyprnosis/modules/updates/update_system.sh"] }
      }

      Rectangle {
        width: 350
        height: 60
        radius: 10
        color: currentIndex === 1 || button2area.containsMouse ? theme.colSelect : theme.colBg
        border.width: 2
        border.color: theme.colAccent

        Text {
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 15
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 22
          text: "Update AUR"
        }

        MouseArea {
          id: button2area
          anchors.fill: parent
          hoverEnabled: true
          onEntered: currentIndex = 1
          onClicked: { currentIndex = 1; button2.startDetached(); updatemenu.visible = false }
        }

        Process { id: button2; command: ["sh","-c","ghostty -e ~/.config/hyprnosis/modules/updates/update_aur.sh"] }
      }

      Rectangle {
        width: 350
        height: 60
        radius: 10
        color: currentIndex === 2 || button3area.containsMouse ? theme.colSelect : theme.colBg
        border.width: 2
        border.color: theme.colAccent

        Text {
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 15
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 22
          text: "Update hyprnosis"
        }

        MouseArea {
          id: button3area
          anchors.fill: parent
          hoverEnabled: true
          onEntered: currentIndex = 2
          onClicked: { currentIndex = 2; button3.startDetached(); updatemenu.visible = false }
        }

        Process { id: button3; command: ["sh","-c","ghostty -e ~/.config/hyprnosis/modules/updates/update_hyprnosis.sh"] }
      }
    }
  }
}

