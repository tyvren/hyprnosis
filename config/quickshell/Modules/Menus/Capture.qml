import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import qs

PanelWindow {
  id: capturemenu
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
    //border.width: 2
    //border.color: theme.colAccent
    
    Image {
      id: logoImage
      anchors.centerIn: parent
      width: 500
      height: 500
      source: theme.logoPath
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
          case 0: button1.startDetached(); break
          case 1: button2.startDetached(); break
          case 2: button3.startDetached(); break
        }
        capturemenu.visible = false
      }

      Item {
        implicitWidth: 250
        implicitHeight: 60

        RectangularShadow {
          anchors.centerIn: parent
          width: 250
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
            text: "󰹑"
          }

          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "Region"
          }

          MouseArea {
            id: button1area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 0
            onClicked: {
              currentIndex = 0
              button1.startDetached()
              capturemenu.visible = false
            }
          }

          Process {
            id: button1
            command: ["hyprshot", "-m", "region"]
          }
        }
      }

      Item {
        implicitWidth: 250
        implicitHeight: 60

        RectangularShadow {
          anchors.centerIn: parent
          width: 250
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
            text: "󰹑"
          }

          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "Window"
          }

          MouseArea {
            id: button2area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 1
            onClicked: {
              currentIndex = 1
              button2.startDetached()
              capturemenu.visible = false
            }
          }

          Process {
            id: button2
            command: ["hyprshot", "-m", "window"]
          }
        }
      }

      Item {
        implicitWidth: 250
        implicitHeight: 60

        RectangularShadow {
          anchors.centerIn: parent
          width: 250
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
            text: ""
          }

          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "Record"
          }

          MouseArea {
            id: button3area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 2
            onClicked: {
              currentIndex = 2
              button3.startDetached()
              capturemenu.visible = false
            }
          }

          Process {
            id: button3
            command: ["obs", "--startrecording"]
          }
        }
      }
    }
  }
}
