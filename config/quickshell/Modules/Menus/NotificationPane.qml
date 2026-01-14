import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import qs.Components
import qs.Services
import qs.Themes

PanelWindow {
  id: notificationPane 
  visible: false
  focusable: true
  color: "transparent"
  anchors.top: true
  anchors.bottom: true
  anchors.right: true
  implicitWidth: 350
  margins.right: 35
  margins.top: 10
  margins.bottom: 10

  WlrLayershell.layer: WlrLayer.Top
  exclusionMode: ExclusionMode.Ignore

  onVisibleChanged: {
    if (visible) {
      Qt.callLater(() => paneRoot.forceActiveFocus())
    }
  }

  IpcHandler {
    target: "notificationpane"
    function toggle(): void {
      notificationPane.visible = !notificationPane.visible
    }
  }

  Rectangle {
    id: paneRoot
    anchors.fill: parent
    color: Theme.colBg
    radius: 20
    border.color: Theme.colAccent
    border.width: 1

    Keys.onEscapePressed: notificationPane.visible = false

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 20
      spacing: 15

      RowLayout {
        Layout.fillWidth: true
        
        Text {
          text: "Notifications"
          color: Theme.colAccent
          font.family: Theme.fontFamily
          font.pointSize: 16
          font.bold: true
        }

        Item { Layout.fillWidth: true }

        Rectangle {
          width: 80
          height: 30
          radius: 8
          color: clearMa.containsMouse ? Theme.colAccent : Theme.colMuted
          
          Text {
            anchors.centerIn: parent
            text: "Clear All"
            color: clearMa.containsMouse ? Theme.colBg : Theme.colAccent
            font.family: Theme.fontFamily
            font.bold: true
            font.pointSize: 10
          }

          MouseArea {
            id: clearMa
            anchors.fill: parent
            hoverEnabled: true
            onClicked: Notifications.clearAll()
          }
        }
      }

      DividerLine {
        Layout.fillWidth: true
      }

      ListView {
        id: notifList
        Layout.fillWidth: true
        Layout.fillHeight: true
        model: Notifications.notifications
        spacing: 12
        clip: true
        
        delegate: Rectangle {
          id: notifDelegate
          width: notifList.width
          implicitHeight: contentCol.height + 30
          color: Theme.colMuted
          radius: 12
          
          ColumnLayout {
            id: contentCol
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 15
            spacing: 5

            RowLayout {
              Layout.fillWidth: true
              
              Text {
                text: modelData.summary
                color: Theme.colAccent
                font.family: Theme.fontFamily
                font.bold: true
                font.pointSize: 11
                Layout.fillWidth: true
                elide: Text.ElideRight
              }

              Text {
                text: "󰅖"
                color: Theme.colAccent
                font.family: Theme.fontFamily
                font.pointSize: 12
                opacity: dismissMa.containsMouse ? 1.0 : 0.6
                
                MouseArea {
                  id: dismissMa
                  anchors.fill: parent
                  hoverEnabled: true
                  onClicked: modelData.dismiss()
                }
              }
            }

            Text {
              text: modelData.body
              color: Theme.colAccent
              font.family: Theme.fontFamily
              font.pointSize: 10
              wrapMode: Text.WordWrap
              Layout.fillWidth: true
              opacity: 0.8
              visible: text !== ""
            }
          }
        }

        Text {
          anchors.centerIn: parent
          text: "No Notifications"
          color: Theme.colAccent
          font.family: Theme.fontFamily
          opacity: 0.4
          visible: notifList.count === 0
        }
      }
    }
  }
}
