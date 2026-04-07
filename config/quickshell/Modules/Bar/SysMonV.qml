import QtQuick
import QtQuick.Layouts
import qs.Services
import qs.Themes

Column {
    id: root
    spacing: 14

    ColumnLayout {
        spacing: 5

        Text {
            text: ""
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 9
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        Text {
            text: Math.round(SysMonitor.cpuUsage) + "%"
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 8
            anchors.left: parent.left
            anchors.leftMargin: 1
        }

        Text {
            text: ""
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 9
            anchors.left: parent.left
            anchors.leftMargin: 5
        }
        
        Text {
            text: Math.round(SysMonitor.ramUsage * 100) + "%"
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 8
            anchors.left: parent.left
            anchors.leftMargin: 1
        }
    }
}
