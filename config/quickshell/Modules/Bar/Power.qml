import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import "../.."

Item {
  id: root
  width: 30
  height: 30

  property bool showMenu: false
  property var theme: Theme {}

  Rectangle {
    anchors.fill: parent
    color: "transparent"

    Text {
      anchors.centerIn: parent
      text: " "
      font.family: theme.fontFamily
      font.pixelSize: theme.fontSize
      color: theme.colAccent
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      root.showMenu = true
      hideTimer.restart();
    }
  }

  Timer {
		id: hideTimer
		interval: 5000
		onTriggered: root.showMenu = false
	}

  LazyLoader {
    active: root.showMenu

    PanelWindow {
      anchors.top: true
      anchors.right: true
			implicitWidth: 140
      implicitHeight: 200
      color: "transparent"

      Rectangle {
				anchors.fill: parent
				radius: height / 10
        color: theme.colTransB
        border.color: theme.colAccent

        Column {
          anchors.centerIn: parent
          spacing: 20

          Item {
            width: 100
            height: 30

            Process {
              id: powerOff
              command: [ "systemctl", "poweroff" ]
              }

            Rectangle {
              anchors.fill: parent
              color: "transparent"
              border.color: theme.colAccent
              radius: 10

              Text {
                anchors.centerIn: parent
                text: " Shutdown"
                font.family: theme.fontFamily
                font.pixelSize: theme.fontSize
                color: theme.colAccent
              }
            }

            MouseArea {
              anchors.fill: parent
              onClicked: {
                powerOff.startDetached()
              }
            }
          }
          
          Item {
            width: 100
            height: 30

            Process {
              id: restart
              command: [ "systemctl", "reboot" ]
              }

            Rectangle {
              anchors.fill: parent
              color: "transparent"
              border.color: theme.colAccent
              radius: 10

              Text {
                anchors.centerIn: parent
                text: " Restart"
                font.family: theme.fontFamily
                font.pixelSize: theme.fontSize
                color: theme.colAccent
              }
            }

            MouseArea {
              anchors.fill: parent
              onClicked: {
                restart.startDetached() 
              }
            }
          }

          Item {
            width: 100
            height: 30

            Process {
              id: lock
              command: [ "hyprlock" ]
              }

            Rectangle {
              anchors.fill: parent
              color: "transparent"
              border.color: theme.colAccent
              radius: 10

              Text {
                anchors.centerIn: parent
                text: " Lock"
                font.family: theme.fontFamily
                font.pixelSize: theme.fontSize
                color: theme.colAccent
              }
            }

            MouseArea {
              anchors.fill: parent
              onClicked: {
                lock.startDetached()
              }
            }
          }
        }
      }
    } 
  }
}
