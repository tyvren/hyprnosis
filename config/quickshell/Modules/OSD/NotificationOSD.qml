import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Services
import qs.Themes

Scope {
  id: root

  property bool shouldShowOsd: false
  property string currentSummary: ""
  property string currentBody: ""

  Connections {
    target: Notifications

    function onNotification(n) {
      root.currentSummary = n.summary
      root.currentBody = n.body
      root.shouldShowOsd = true
      hideTimer.restart()
    }
  }

  Timer {
    id: hideTimer
    interval: 2500
    onTriggered: root.shouldShowOsd = false
  }

  LazyLoader {
    active: root.shouldShowOsd

    PanelWindow {
      anchors.top: true
      anchors.right: true
      margins.top: 10
      margins.right: 10 
      implicitWidth: screen.width / 6
      implicitHeight: screen.height / 18
      color: "transparent"
      mask: Region {}

      Item {
        anchors.fill: parent

        Rectangle {
          anchors.fill: parent
          radius: 15
          color: Theme.colBg
          border.color: Theme.colAccent
          border.width: 1

          RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            spacing: 12

            Text {
              color: Theme.colHilight
              font.pixelSize: 25
              text: "󰂚"
              Layout.alignment: Qt.AlignVCenter
            }

            ColumnLayout {
              Layout.fillWidth: true
              Layout.alignment: Qt.AlignVCenter
              spacing: 0

              Text {
                text: root.currentSummary
                color: Theme.colHilight
                font.bold: true
                font.pixelSize: 14
                elide: Text.ElideRight
                Layout.fillWidth: true
              }

              Text {
                text: root.currentBody
                color: "white"
                font.pixelSize: 11
                elide: Text.ElideRight
                maximumLineCount: 1
                Layout.fillWidth: true
                visible: text !== ""
              }
            }
          }
        }
      }
    }
  }
}
