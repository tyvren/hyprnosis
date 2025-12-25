import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland
import qs

PanelWindow {
  id: packagesmenu
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
    target: "packagesmenu"
    function toggle(): void { packagesmenu.visible = !packagesmenu.visible }
    function hide(): void { packagesmenu.visible = false }
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

    Keys.onEscapePressed: packagesmenu.visible = false
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
        packagesmenu.visible = false
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
          color: currentIndex === 0 || button1area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pointSize: 18
            text: "󰣇"
          }
          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pointSize: 14
            text: "Install ArchPkg"
          }
          MouseArea {
            id: button1area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 0
            onClicked: {
              currentIndex = 0
              button1.startDetached()
              packagesmenu.visible = false
            }
          }
          Process {
            id: button1
            command: ["sh", "-c", "ghostty -e ~/.config/hyprnosis/modules/packages/pkg_install.sh"]
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
          color: currentIndex === 1 || button2area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pointSize: 18
            text: ""
          }
          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pointSize: 14
            text: "Install AURPkg"
          }
          MouseArea {
            id: button2area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 1
            onClicked: {
              currentIndex = 1
              button2.startDetached()
              packagesmenu.visible = false
            }
          }
          Process {
            id: button2
            command: ["sh", "-c", "ghostty -e ~/.config/hyprnosis/modules/packages/pkg_aur_install.sh"]
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
          color: currentIndex === 2 || button3area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pointSize: 18
            text: "󱧙"
          }
          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pointSize: 14
            text: "Uninstall Pkg"
          }
          MouseArea {
            id: button3area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 2
            onClicked: {
              currentIndex = 2
              button3.startDetached()
              packagesmenu.visible = false
            }
          }
          Process {
            id: button3
            command: ["sh", "-c", "ghostty -e ~/.config/hyprnosis/modules/packages/pkg_uninstall.sh"]
          }
        }
      }
    }
  }
}
