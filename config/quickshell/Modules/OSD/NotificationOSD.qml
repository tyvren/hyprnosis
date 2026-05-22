import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Components
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

        OSD {
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 15
                anchors.rightMargin: 15
                spacing: 12

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 4

                    Text {
                        text: root.currentSummary
                        color: Theme.colText
                        font.bold: true
                        font.pointSize: 12
                        elide: Text.ElideRight
                        maximumLineCount: 2
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }

                    Text {
                        text: root.currentBody
                        color: Theme.colText
                        font.pointSize: 11
                        elide: Text.ElideRight
                        maximumLineCount: 2
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                        visible: text !== ""
                    }
                }
            }
        }
    }
}
