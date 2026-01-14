import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

PopupWindow {
  id: root
  implicitWidth: 500
  implicitHeight: 300
  anchor.window: shell
  anchor.rect.x: shell.width / 2 - width / 2
  anchor.rect.y: 0
  color: "transparent"

  property var theme: Theme {}
  property var menuItems: [
  { text: "Button1", cmd: "loginctl lock-session" },
  { text: "Button2", cmd: "systemctl reboot" },
  { text: "Button3", cmd: "systemctl poweroff" }
  ]

  Rectangle {
    anchors.fill: parent
    bottomLeftRadius: 15
    bottomRightRadius: 15
    color: theme.colBg

    ColumnLayout {
      anchors.centerIn: parent
      spacing: 8
        
      Repeater {
        model: menuItems 

        Rectangle {
          id: button
          width: 350
          height: 60
          radius: 10
          color: theme.colBg
          border.width: 2
          border.color: theme.colAccent

          Text {
            anchors.centerIn: parent
            font.pixelSize: 28
            color: theme.colAccent 
            text: modelData.text
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: border.color = theme.colHilight
            onClicked: {
              Quickshell.exec(modelData.cmd)
              root.visible = false
            }
          }
        }
      }
    }
  }
}
