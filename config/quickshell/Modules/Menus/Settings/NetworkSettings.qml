import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import qs.Components
import qs.Services
import qs.Themes

Item {
    id: networkRoot
    property var selectedNetwork: null

    Connections {
        target: Network
        function onNetworksChanged() {
            if (selectedNetwork && Network.isConnected(selectedNetwork.ssid)) {
                selectedNetwork = null
                Network.errorMessage = ""
                passInput.text = ""
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 15
        opacity: selectedNetwork !== null ? 0.4 : 1.0
        Behavior on opacity { NumberAnimation { duration: 200 } }

        Rectangle {
            id: ethernetBar
            Layout.fillWidth: true
            Layout.preferredHeight: 50 
            color: Network.ethernetConnected ? Theme.colMuted : Theme.colAccent
            opacity: Network.ethernetConnected ? 1 : 0.2
            radius: 5
            visible: Network.ethernetConnected

            Item {
                anchors.fill: parent

                Text {
                    id: ethIcon
                    text: "󰈀"
                    color: Theme.colAccent
                    font.pointSize: 14
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                }

                Text {
                    text: "Ethernet (" + Network.ethernetInterface + ")"
                    color: Theme.colText
                    font.bold: true
                    font.family: Theme.fontFamily
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: ethIcon.right
                    anchors.leftMargin: 10
                }

                Text {
                    text: "Connected"
                    color: Theme.colText
                    font.pointSize: 9
                    font.family: Theme.fontFamily
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 15
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true

            Text {
                text: "Wi-Fi"
                color: Theme.colAccent
                font.pointSize: 14
                font.family: Theme.fontFamily
            }

            Item { Layout.fillWidth: true }

            StyledSwitch {
                id: wifiToggle
                checked: Network.wifiEnabled
                onToggled: Network.setWifiEnabled(checked)
            }
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ListView {
                model: Object.values(Network.networks).sort((a,b) => b.signal - a.signal)
                spacing: 8

                delegate: ItemDelegate {
                    width: parent.width
                    height: 50
                    enabled: selectedNetwork === null

                    background: Rectangle {
                        color: modelData.connected ? Theme.colAccent : Theme.colMuted
                        opacity: modelData.connected ? 0.2 : 0.1
                        radius: 5
                    }

                    contentItem: Item {
                        anchors.fill: parent

                        Text {
                            id: signalIcon
                            text: Network.signalIcon(modelData.signal)
                            color: Theme.colAccent
                            font.pointSize: 14
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                        }

                        Column {
                            id: labelColumn
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: signalIcon.right
                            anchors.leftMargin: 15
                            spacing: 0

                            Text {
                                text: modelData.ssid
                                color: Theme.colText
                                font.bold: modelData.connected
                                font.family: Theme.fontFamily
                            }
                            Text {
                                text: modelData.connected ? "Connected" : (modelData.secured ? "Secured" : "Open")
                                color: modelData.connected ? Theme.colText : Theme.colMuted
                                font.bold: modelData.connected
                                font.pointSize: 8
                                font.family: Theme.fontFamily
                            }
                        }

                        StyledButton {
                            visible: modelData.connected
                            width: 80
                            height: 24
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 15
                            text: "Forget"

                            onClicked: Network.forget(modelData.ssid)
                        }

                        Text {
                            visible: modelData.secured && !modelData.connected
                            text: "󰌾"
                            color: Theme.colMuted
                            font.pointSize: 10
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 15
                        }
                    }

                    onClicked: {
                        if (modelData.connected) return
                        if (modelData.secured) {
                            Network.errorMessage = ""
                            networkRoot.selectedNetwork = modelData
                        } else {
                            Network.connect(modelData.ssid)
                        }
                    }
                }
            }
        }

        StyledButton {
            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: 100
            Layout.preferredHeight: 35
            text: Network.scanning ? "..." : "Rescan"
            active: Network.scanning

            onClicked: Network.scan()
        }
    }

    Rectangle {
        id: authModal
        anchors.centerIn: parent
        width: parent.width * 0.7
        height: 260
        color: Theme.colBg
        visible: selectedNetwork !== null
        radius: 5
        border.color: Theme.colAccent
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 25
            spacing: 15

            Text {
                Layout.fillWidth: true
                text: "Authentication"
                color: Theme.colAccent
                font.pointSize: 14
                font.family: Theme.fontFamily
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                Layout.fillWidth: true
                text: selectedNetwork ? selectedNetwork.ssid : ""
                color: Theme.colMuted
                font.pointSize: 10
                font.family: Theme.fontFamily
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                id: passInput
                Layout.fillWidth: true
                placeholderText: "Password..."
                placeholderTextColor: Theme.colMuted
                echoMode: TextInput.Password
                color: Theme.colAccent
                font.family: Theme.fontFamily
                padding: 10
                background: Rectangle {
                    color: Theme.colMuted
                    opacity: 0.1
                    radius: 5
                    border.color: Theme.colAccent
                    border.width: 1
                }
                onAccepted: if (!Network.connecting) Network.connect(selectedNetwork.ssid, passInput.text)
            }

            Text {
                visible: Network.errorMessage !== ""
                text: Network.errorMessage
                color: "#ff5555"
                font.pointSize: 9
                Layout.alignment: Qt.AlignHCenter
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15

                StyledButton {
                    Layout.preferredWidth: 110
                    Layout.preferredHeight: 40
                    enabled: !Network.connecting
                    text: "Cancel"

                    onClicked: {
                        networkRoot.selectedNetwork = null
                        Network.errorMessage = ""
                        passInput.text = ""
                    }
                }

                StyledButton {
                    Layout.preferredWidth: 110
                    Layout.preferredHeight: 40
                    text: Network.connecting ? "..." : "Connect"
                    active: Network.connecting

                    onClicked: {
                        if (Network.connecting) return
                        Network.connect(selectedNetwork.ssid, passInput.text)
                    }
                }
            }
        }
    }
}
