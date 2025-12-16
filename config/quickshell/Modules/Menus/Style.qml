import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland
import "../.."

PanelWindow {
  id: stylemenu
  visible: false
  focusable: true
  color: "transparent"
  property var theme: Theme {}
  property int currentIndex: 0

  anchors { top: true; bottom: true; left: true; right: true }

  onVisibleChanged: {
    if (visible) {
      currentIndex = 0
      Qt.callLater(() => menuroot.forceActiveFocus())
    }
  }

  IpcHandler {
    target: "stylemenu"
    function toggle(): void { stylemenu.visible = !stylemenu.visible }
    function hide(): void { stylemenu.visible = false }
  }

  RectangularShadow {
    cached: true
    anchors.centerIn: parent
    width: 400
    height: 200
    blur: 50
    spread: 5
    radius: 10
  }

  Rectangle {
    id: menuroot
    anchors.centerIn: parent
    width: 400
    height: 200
    radius: 10
    color: theme.colBg
    border.width: 2
    border.color: theme.colAccent

    Keys.onEscapePressed: stylemenu.visible = false
    Keys.onUpPressed: currentIndex = (currentIndex - 1 + menulist.count) % menulist.count
    Keys.onDownPressed: currentIndex = (currentIndex + 1) % menulist.count
    Keys.onReturnPressed: menulist.activate(currentIndex)
    Keys.onEnterPressed: menulist.activate(currentIndex)

    ColumnLayout {
      id: menulist
      anchors.centerIn: parent
      spacing: 8
      property int count: 2

      function activate(index) {
        switch (index) {
          case 0: button1.startDetached(); break
          case 1: button2.startDetached(); break
        }
        stylemenu.visible = false
      }

      Item {
        implicitWidth: 350
        implicitHeight: 60

        RectangularShadow {
          anchors.centerIn: parent
          width: 350
          height: 60
          blur: 5
          spread: 1
          radius: 10
        }

        Rectangle {
          anchors.fill: parent
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
            text: ""
          }

          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "Theme"
          }

          MouseArea {
            id: button1area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 0
            onClicked: {
              currentIndex = 0
              button1.startDetached()
              stylemenu.visible = false
            }
          }

          Process {
            id: button1
            command: [ "sh", "-c", "qs ipc call thememenu toggle" ]
          }
        }
      }

      Item {
        implicitWidth: 350
        implicitHeight: 60

        RectangularShadow {
          anchors.centerIn: parent
          width: 350
          height: 60
          blur: 5
          spread: 1
          radius: 10
        }

        Rectangle {
          anchors.fill: parent
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
            text: "󰸉"
          }

          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "Wallpaper"
          }

          MouseArea {
            id: button2area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 1
            onClicked: {
              currentIndex = 1
              button2.startDetached()
              stylemenu.visible = false
            }
          }

          Process {
            id: button2
            command: [ "sh", "-c", "qs ipc call wallpapersmenu toggle" ]
          }
        }
      }
    }
  }
}
