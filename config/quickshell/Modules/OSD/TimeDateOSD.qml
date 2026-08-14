import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Themes
import qs.Services

Item {
    id: root
    implicitWidth: 480
    implicitHeight: 28

    OSD {
        id: osdRoot
        anchors.fill: parent
        active: States.timeDateOSDOpen

        Item {
            id: osdContainer
            anchors.fill: parent

            Rectangle {
                id: cpuBadge
                anchors.left: parent.left
                anchors.leftMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                width: cpuRow.width + 12
                height: 20
                radius: Config.data.rounding
                color: Theme.colMuted

                Row {
                    id: cpuRow
                    spacing: 5
                    anchors.centerIn: parent

                    StyledText {
                        text: ""
                        color: Theme.colAccent
                        size: 9
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    StyledText {
                        text: Math.round(SysMonitor.cpuUsage) + "%"
                        color: Theme.colAccent
                        bold: true
                        size: 8
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 6
                    height: 2
                    radius: 1
                    color: Theme.colMuted 

                    Rectangle {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: parent.width * Math.min(Math.max(SysMonitor.cpuUsage / 100, 0), 1)
                        color: Theme.colAccent
                        radius: 1
                    }
                }
            }

            Clock {
                id: clock
                anchors.centerIn: parent
                orientation: "horizontalFull"
            }

            Rectangle {
                id: ramBadge
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                width: ramRow.width + 12
                height: 20
                radius: Config.data.rounding
                color: Theme.colMuted 

                Row {
                    id: ramRow
                    spacing: 5
                    anchors.centerIn: parent

                    StyledText {
                        text: ""
                        color: Theme.colAccent
                        size: 9
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    StyledText {
                        text: Math.round(SysMonitor.ramUsage * 100) + "%"
                        color: Theme.colAccent
                        bold: true
                        size: 8
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 6
                    height: 2
                    radius: 1
                    color: Theme.colMuted 

                    Rectangle {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: parent.width * Math.min(Math.max(SysMonitor.ramUsage, 0), 1)
                        color: Theme.colAccent
                        radius: 1
                    }
                }
            }
        }
    }
}
