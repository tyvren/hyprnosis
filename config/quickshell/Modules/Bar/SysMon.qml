import QtQuick
import qs.Services
import qs.Themes

Row {
    id: root
    spacing: 14

    Column {
        spacing: -2

        Text {
            text: ""
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 9
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: Math.round(SysMonitor.cpuUsage) + "%"
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 8
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Column {
        spacing: -2

        Text {
            text: ""
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 9
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: Math.round(SysMonitor.ramUsage * 100) + "%"
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 8
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
