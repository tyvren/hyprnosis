import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import qs.Components
import qs.Services
import qs.Themes

PanelWindow {
    id: sidePane
    visible: false
    focusable: true
    color: "transparent"
    anchors.top: true
    anchors.bottom: true
    anchors.right: true
    implicitWidth: 350
    margins.right: 10
    margins.top: 35
    margins.bottom: 35

    exclusionMode: ExclusionMode.Ignore

    HyprlandFocusGrab {
        id: focusGrab
        windows: [sidePane]
        onCleared: sidePane.visible = false
    }

    onVisibleChanged: {
        if (visible) {
            Qt.callLater(() => paneRoot.forceActiveFocus())
            focusGrab.active = true
        } else {
            focusGrab.active = false
        }
    }

    IpcHandler {
        target: "sidePane"
        function toggle(): void {
            sidePane.visible = !sidePane.visible
        }
    }

    Rectangle {
        id: paneRoot
        anchors.fill: parent
        color: Theme.colBg
        radius: 10
        border.color: Theme.colAccent
        border.width: 1

        Keys.onEscapePressed: sidePane.visible = false

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15

            Rectangle {
                Layout.fillWidth: true
                height: controlsColumn.implicitHeight + 24
                color: Theme.colMuted
                radius: 12

                ColumnLayout {
                    id: controlsColumn
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: 14
                    spacing: 12

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Text {
                            text: {
                                const b = Brightness.brightness
                                if (b < 0.25) return "󰃞"
                                if (b < 0.6)  return "󰃟"
                                return "󰃠"
                            }
                            color: Theme.colAccent
                            font.family: Theme.fontFamily
                            font.pointSize: 13
                        }

                        Item {
                            Layout.fillWidth: true
                            height: 20

                            Rectangle {
                                id: trackBg
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width
                                height: 5
                                radius: 3
                                color: Qt.rgba(1, 1, 1, 0.12)
                            }

                            Rectangle {
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: trackBg.left
                                width: trackBg.width * Brightness.brightness
                                height: 5
                                radius: 3
                                color: Theme.colAccent

                                Behavior on width {
                                    NumberAnimation { duration: 80; easing.type: Easing.OutQuad }
                                }
                            }

                            Rectangle {
                                id: thumb
                                anchors.verticalCenter: parent.verticalCenter
                                x: (trackBg.width * Brightness.brightness) - (width / 2)
                                width: 14
                                height: 14
                                radius: 7
                                color: Theme.colAccent
                                border.color: Theme.colBg
                                border.width: 2

                                Behavior on x {
                                    NumberAnimation { duration: 80; easing.type: Easing.OutQuad }
                                }
                            }

                            MouseArea {
                                anchors.fill: trackBg
                                anchors.margins: -8
                                hoverEnabled: true
                                preventStealing: true

                                function updateBrightness(mouse) {
                                    const val = Math.max(0, Math.min(1, mouse.x / trackBg.width))
                                    Brightness.setBrightness(val)
                                }

                                onPressed: (mouse) => updateBrightness(mouse)
                                onPositionChanged: (mouse) => {
                                    if (pressed) updateBrightness(mouse)
                                }
                            }
                        }

                        Text {
                            text: Math.round(Brightness.brightness * 100) + "%"
                            color: Theme.colAccent
                            font.family: Theme.fontFamily
                            font.pointSize: 9
                            opacity: 0.75
                            horizontalAlignment: Text.AlignRight
                            Layout.minimumWidth: 32
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true

                Text {
                    text: "Notifications"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pointSize: 11
                    font.bold: true
                }

                Item { Layout.fillWidth: true }

                Rectangle {
                    width: 80
                    height: 30
                    radius: 8
                    color: clearMa.containsMouse ? Theme.colAccent : Theme.colMuted

                    Text {
                        anchors.centerIn: parent
                        text: "Clear All"
                        color: clearMa.containsMouse ? Theme.colBg : Theme.colAccent
                        font.family: Theme.fontFamily
                        font.bold: true
                        font.pointSize: 10
                    }

                    MouseArea {
                        id: clearMa
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: Notifications.clearAll()
                    }
                }
            }

            DividerLine {
                Layout.fillWidth: true
            }

            ListView {
                id: notifList
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: Notifications.notifications
                spacing: -70
                clip: false

                delegate: Rectangle {
                    id: notifDelegate
                    visible: index < 3
                    width: notifList.width * (1 - (index * 0.03))
                    anchors.horizontalCenter: notifList.horizontalCenter
                    height: 100
                    color: Theme.colMuted
                    radius: 10
                    z: (notifList.count - index)

                    RectangularShadow {
                        anchors.fill: parent
                        color: Qt.rgba(0, 0, 0, 0.3)
                        blur: 15
                        radius: 12
                    }

                    ColumnLayout {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: 15
                        spacing: 5

                        RowLayout {
                            Layout.fillWidth: true

                            Text {
                                text: modelData.summary
                                color: Theme.colAccent
                                font.family: Theme.fontFamily
                                font.bold: true
                                font.pointSize: 11
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            Text {
                                text: "󰅖"
                                color: Theme.colAccent
                                font.family: Theme.fontFamily
                                font.pointSize: 12
                                opacity: dismissMa.containsMouse ? 1.0 : 0.6

                                MouseArea {
                                    id: dismissMa
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: modelData.dismiss()
                                }
                            }
                        }

                        Text {
                            text: modelData.body
                            color: Theme.colAccent
                            font.family: Theme.fontFamily
                            font.pointSize: 10
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true
                            opacity: 0.8
                            visible: text !== ""
                        }
                    }
                }
            }
        }
    }
}
