import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import qs

PanelWindow {
  id: utilmenu
  visible: false
  focusable: true
  color: "transparent"
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
    color: theme.colAccent
  }

  Rectangle {
    id: menuRoot
    focus: true
    anchors.centerIn: parent
    width: 400
    height: 300
    radius: 10
    color: theme.colBg
    //border.width: 2
    //border.color: theme.colAccent

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
            text: "Configure Hyprland"
          }

          MouseArea {
            id: button1area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 0
            onClicked: {
              currentIndex = 0
              button1.startDetached()
              utilmenu.visible = false
            }
          }
          Process {
            id: button1
            command: ["sh","-c","ghostty -e ~/.config/hyprnosis/modules/quickconfig/quickconfig.sh"]
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
            text: "󱊟"
          }
          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "ISO Image Writer"
          }

          MouseArea {
            id: button2area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 1
            onClicked: {
              currentIndex = 1
              button2.startDetached()
              utilmenu.visible = false
            }
          }
          Process {
            id: button2
            command: ["sh","-c","ghostty -e ~/.config/hyprnosis/modules/diskmanagement/write_iso.sh"]
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
            text: "󱁋"
          }
          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "Mount Disk"
          }

          MouseArea {
            id: button3area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 2
            onClicked: {
              currentIndex = 2
              button3.startDetached()
              utilmenu.visible = false
            }
          }
          Process {
            id: button3
            command: ["sh","-c","ghostty -e ~/.config/hyprnosis/modules/diskmanagement/mount_disk.sh"]
          }
        }
      }
    }
  }
}
