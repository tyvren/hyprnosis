import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import qs.Themes

PanelWindow {
  id: stylemenu
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
    target: "stylemenu"
    function toggle(): void { stylemenu.visible = !stylemenu.visible }
    function hide(): void { stylemenu.visible = false }
  }

  RectangularShadow {
    anchors.centerIn: parent
    width: 400
    height: 200
    blur: 10
    spread: 0
    radius: 10
    color: "transparent"
  }

  Rectangle {
    id: menuroot
    anchors.centerIn: parent
    width: 400
    height: 200
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
        implicitWidth: 225
        implicitHeight: 60
        RectangularShadow {
          anchors.centerIn: parent
          width: 225
          height: 60
          blur: 5
          spread: 1
          radius: 50
        }
        Rectangle {
          anchors.fill: parent
          radius: 50
          color: currentIndex === 0 || button1area.containsMouse ? Theme.colSelect : Theme.colBg
          border.width: 2
          border.color: Theme.colAccent
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            color: Theme.colAccent
            font.family: Theme.fontFamily
            font.pointSize: 18
            text: ""
          }
          Text {
            anchors.centerIn: parent
            color: Theme.colAccent
            font.family: Theme.fontFamily
            font.pointSize: 14
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
            command: ["sh", "-c", "qs ipc call thememenu toggle"]
          }
        }
      }

      Item {
        implicitWidth: 225
        implicitHeight: 60
        RectangularShadow {
          anchors.centerIn: parent
          width: 225
          height: 60
          blur: 5
          spread: 1
          radius: 50
        }
        Rectangle {
          anchors.fill: parent
          radius: 50
          color: currentIndex === 1 || button2area.containsMouse ? Theme.colSelect : Theme.colBg
          border.width: 2
          border.color: Theme.colAccent
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            color: Theme.colAccent
            font.family: Theme.fontFamily
            font.pointSize: 18
            text: "󰸉"
          }
          Text {
            anchors.centerIn: parent
            color: Theme.colAccent
            font.family: Theme.fontFamily
            font.pointSize: 14
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
            command: ["sh", "-c", "qs ipc call wallpapersmenu toggle"]
          }
        }
      }
    }
  }
}
