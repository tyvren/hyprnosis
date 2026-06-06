import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Services
import qs.Themes

Item {
    id: root
    implicitWidth: 400
    implicitHeight: 28

    property bool shouldShowOsd: false
    property string currentSummary: ""
    property string currentBody: ""

    Scope {
        id: notificationScope

        Connections {
            target: Notifications

            function onNotification(n) {
                root.currentSummary = n.summary
                root.currentBody = n.body
                root.shouldShowOsd = true
                hideTimer.restart()
            }
        }
    }

    Timer {
        id: hideTimer
        interval: 3500
        onTriggered: root.shouldShowOsd = false
    }

    OSD {
        id: osdComponent
        anchors.fill: parent
        active: root.shouldShowOsd

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            spacing: 12

            Text {
                text: root.currentSummary
                color: Theme.colText
                font.bold: true
                font.pointSize: 12
                elide: Text.ElideRight
                maximumLineCount: 1
                wrapMode: Text.Wrap
            }

            Text {
                text: root.currentBody
                color: Theme.colText
                font.pointSize: 11
                elide: Text.ElideRight
                maximumLineCount: 1
                wrapMode: Text.Wrap
                Layout.fillWidth: true
                visible: text !== ""
            }
        }
    }
}
