import QtQuick
import qs.Services
import qs.Themes

Column {
    id: root
    spacing: 6

    Column {
        spacing: 0

        Text {
            text: ""
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 8
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: Math.round(SysMonitor.cpuUsage) + "%"
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 6
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Column {
        spacing: 0

        Text {
            text: ""
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 8
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: Math.round(SysMonitor.ramUsage * 100) + "%"
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 6
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
