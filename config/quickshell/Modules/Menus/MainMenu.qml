import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland
import "../.."

PanelWindow {
  id: mainmenu
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
    target: "mainmenu"
    function toggle(): void { mainmenu.visible = !mainmenu.visible }
    function hide(): void { mainmenu.visible = false }
  }

  RectangularShadow {
    anchors.centerIn: parent
    width: 400
    height: 500
    blur: 50
    spread: 5
    radius: 10
  }

  Rectangle {
    id: menuroot
    anchors.centerIn: parent
    width: 400
    height: 500
    radius: 10
    color: theme.colBg
    border.width: 2
    border.color: theme.colAccent

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
        [button1, button2, button3, button4, button5, button6][i].startDetached()
        mainmenu.visible = false
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
            font.pixelSize: 28
            font.family: theme.fontFamily
            color: theme.colAccent
            text: ""
          }
          Text {
            anchors.centerIn: parent
            font.pixelSize: 22
            font.family: theme.fontFamily
            color: theme.colAccent
            text: "Apps"
          }
          MouseArea {
            id: button1area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 0
            onClicked: menulist.activate(0)
          }
          Process { id: button1; command: [ "sh", "-c", "qs ipc call launcher-menu toggle" ] }
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
            font.pixelSize: 28
            font.family: theme.fontFamily
            color: theme.colAccent
            text: ""
          }
          Text {
            anchors.centerIn: parent
            font.pixelSize: 22
            font.family: theme.fontFamily
            color: theme.colAccent
            text: "Packages"
          }
          MouseArea {
            id: button2area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 1
            onClicked: menulist.activate(1)
          }
          Process { id: button2; command: [ "sh", "-c", "qs ipc call packagesmenu toggle" ] }
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
          color: currentIndex === 2 || button3area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            font.pixelSize: 28
            font.family: theme.fontFamily
            color: theme.colAccent
            text: ""
          }
          Text {
            anchors.centerIn: parent
            font.pixelSize: 22
            font.family: theme.fontFamily
            color: theme.colAccent
            text: "Style"
          }
          MouseArea {
            id: button3area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 2
            onClicked: menulist.activate(2)
          }
          Process { id: button3; command: [ "sh", "-c", "qs ipc call stylemenu toggle" ] }
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
          color: currentIndex === 3 || button4area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            font.pixelSize: 28
            font.family: theme.fontFamily
            color: theme.colAccent
            text: "󰹑"
          }
          Text {
            anchors.centerIn: parent
            font.pixelSize: 22
            font.family: theme.fontFamily
            color: theme.colAccent
            text: "Capture"
          }
          MouseArea {
            id: button4area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 3
            onClicked: menulist.activate(3)
          }
          Process { id: button4; command: [ "sh", "-c", "qs ipc call capturemenu toggle" ] }
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
          color: currentIndex === 4 || button5area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            font.pixelSize: 28
            font.family: theme.fontFamily
            color: theme.colAccent
            text: ""
          }
          Text {
            anchors.centerIn: parent
            font.pixelSize: 22
            font.family: theme.fontFamily
            color: theme.colAccent
            text: "Update"
          }
          MouseArea {
            id: button5area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 4
            onClicked: menulist.activate(4)
          }
          Process { id: button5; command: [ "sh", "-c", "qs ipc call updatemenu toggle" ] }
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
          color: currentIndex === 5 || button6area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            font.pixelSize: 28
            font.family: theme.fontFamily
            color: theme.colAccent
            text: ""
          }
          Text {
            anchors.centerIn: parent
            font.pixelSize: 22
            font.family: theme.fontFamily
            color: theme.colAccent
            text: "Utilities"
          }
          MouseArea {
            id: button6area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 5
            onClicked: menulist.activate(5)
          }
          Process { id: button6; command: [ "sh", "-c", "qs ipc call utilmenu toggle" ] }
        }
      }
    }
  }
}
