import qs
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

PopupWindow {
  id: root
  implicitWidth: 350
  implicitHeight: 225
  anchor.window: barLayer
  anchor.rect.x: barLayer.width / 2 - width / 2
  anchor.rect.y: 40
  color: "transparent"

  property var theme: Theme {}

  Rectangle {
    id: container
    anchors.fill: parent
    radius: 20
    color: theme.colBg
    border.color: theme.colAccent
    border.width: 2
    opacity: root.visible ? 1.0 : 0.0

    Behavior on opacity {
      NumberAnimation {
        duration: 500
      }
    }

    GridLayout {
      columns: 1
      anchors.fill: parent
      anchors.margins: 15

      DayOfWeekRow {
        locale: grid.locale
        Layout.fillWidth: true
        delegate: Text {
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          text: model.shortName
          font.family: theme.fontFamily
          font.pointSize: 16
          color: theme.colAccent
        }
      }

      MonthGrid {
        id: grid
        readonly property date today: new Date()
        month: today.getMonth()
        year: today.getFullYear()
        locale: Qt.locale("en_US")
        Layout.fillWidth: true
        Layout.fillHeight: true
        delegate: Text {
          required property var model
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          text: model.day
          font.family: theme.fontFamily
          font.pointSize: 16
          color: model.today ? theme.colHilight : model.month === grid.month
              ? theme.colAccent : "transparent"
        }
      }
    }
  }
}
