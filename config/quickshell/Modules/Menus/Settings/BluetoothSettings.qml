import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.Components
import qs.Services
import qs.Themes

Item {
    id: bluetoothRoot

    ColumnLayout {
        anchors.fill: parent
        spacing: 15

        RowLayout {
            Layout.fillWidth: true

            Text { 
                text: "Bluetooth"
                color: Theme.colAccent
                font.pointSize: 14 
                font.family: Theme.fontFamily
                Layout.alignment: Qt.AlignVCenter
            }

            Item { Layout.fillWidth: true }
            
            StyledSwitch {
                id: btToggle
                checked: Bluetooth.enabled
                onToggled: Bluetooth.togglePower()
                Layout.alignment: Qt.AlignVCenter
            }
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ListView {
                model: Bluetooth.devices
                spacing: 8
                delegate: ItemDelegate {
                    id: deviceDelegate
                    width: parent.width
                    height: 55

                    background: Rectangle {
                        color: modelData.connected ? Theme.colAccent : Theme.colMuted
                        opacity: modelData.connected ? 0.2 : 0.1
                        radius: 5

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Bluetooth.connectDevice(modelData)
                        }
                    }

                    contentItem: Item {
                        anchors.fill: parent

                        Text { 
                            id: btIcon
                            text: Bluetooth.getIcon(modelData)
                            color: Theme.colAccent
                            font.pointSize: 14 
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                        }

                        Column {
                            id: btLabelColumn
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: btIcon.right
                            anchors.leftMargin: 15
                            spacing: 0

                            Text { 
                                text: modelData.name
                                color: Theme.colText
                                font.bold: modelData.connected
                                font.family: Theme.fontFamily
                            }
                            Text { 
                                text: modelData.connected ? "Connected" : (modelData.paired ? "Paired" : "Available")
                                color: Theme.colMuted
                                font.pointSize: 8
                                font.family: Theme.fontFamily
                            }
                        }

                        StyledButton {
                            visible: modelData.paired || modelData.connected
                            width: 75
                            height: 26
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 15
                            text: "Forget"
                            
                            onClicked: Bluetooth.forgetDevice(modelData)
                        }
                    }
                }
            }
        }

        StyledButton {
            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: 100
            Layout.preferredHeight: 35
            text: Bluetooth.scanning ? "..." : "Scan"
            active: Bluetooth.scanning

            onClicked: Bluetooth.toggleScan()
        }
    }
}
