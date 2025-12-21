import qs
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PopupWindow {
  id: root
  implicitWidth: 500
  implicitHeight: 300
  anchor.window: shell
  anchor.rect.x: shell.width / 2 - width / 2
  anchor.rect.y: 0
  color: "transparent"

  property var theme: Theme {}

  Rectangle {
    anchors.fill: parent
    bottomLeftRadius: 15
    bottomRightRadius: 15
    color: theme.colBg

    GridLayout {
      columns: 1
      anchors.fill: parent
      anchors.topMargin: 20

      DayOfWeekRow {
        locale: grid.locale
        Layout.column: 0
        Layout.fillWidth: true
        delegate: Text {
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          text: model.shortName
          font.family: theme.fontFamily
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
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          text: model.day
          font.family: theme.fontFamily
          color: model.today ? theme.colHilight : model.month === grid.month ? theme.colAccent : "transparent"
        }
      }
    }
  }
}
