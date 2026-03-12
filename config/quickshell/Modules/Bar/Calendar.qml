import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Themes

PopupWindow {
    id: calendarRoot
    implicitWidth: 350
    implicitHeight: 225
    color: "transparent"

    Rectangle {
        id: container
        anchors.fill: parent
        radius: 20
        color: Theme.colBg
        border.color: Theme.colAccent
        border.width: 2
        opacity: calendarRoot.visible ? 1.0 : 0.0

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
                    font.family: Theme.fontFamily
                    font.pointSize: 16
                    color: Theme.colAccent
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
                    font.family: Theme.fontFamily
                    font.pointSize: 16
                    color: model.today ? Theme.colHilight : model.month === grid.month
                            ? Theme.colAccent : "transparent"
                }
            }
        }
    }
}
