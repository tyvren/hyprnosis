import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
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
    margins.right: 35
    margins.top: 35
    margins.bottom: 35

    exclusionMode: ExclusionMode.Ignore

    onVisibleChanged: {
        if (visible) {
            Qt.callLater(() => paneRoot.forceActiveFocus())
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
        radius: 20
        border.color: Theme.colAccent
        border.width: 1

        Keys.onEscapePressed: sidePane.visible = false

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15

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

            Rectangle {
                id: playerContainer
                Layout.fillWidth: true
                implicitHeight: 350
                color: "transparent"
                visible: Players.active !== null

                MultiEffect {
                    id: mediaShadow
                    anchors.fill: playerMain
                    source: playerMain
                    shadowEnabled: true
                    shadowColor: Theme.colAccent
                    shadowBlur: 0.5
                    shadowOpacity: 0.7
                }

                Rectangle {
                    id: playerMain
                    anchors.fill: parent
                    color: "transparent"

                    ClippingRectangle {
                        id: bgImageContainer
                        anchors.fill: playerMain
                        anchors.margins: 5
                        opacity: 0.6
                        radius: 15
                        color: "transparent"

                        Image {
                            id: backgroundImage
                            anchors.fill: parent
                            asynchronous: true
                            fillMode: Image.PreserveAspectCrop
                            visible: false
                            source: Players.active?.trackArtUrl || ""
                        }

                        MultiEffect {
                            id: bgImageEffect
                            anchors.fill: parent
                            source: backgroundImage
                            blurEnabled: true
                            blur: 0.8
                        }
                    }

                    Rectangle {
                        id: trackInfo
                        width: 215
                        height: 240
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: Theme.colBg
                        radius: 15
                        clip: true

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 4
                            spacing: 4

                            Text {
                                Layout.fillWidth: true
                                horizontalAlignment: Text.AlignHCenter
                                color: Theme.colAccent
                                font.pointSize: 10
                                font.bold: true
                                font.family: Theme.fontFamily
                                text: Players.active ? Players.active.trackTitle : ""
                                elide: Text.ElideRight
                            }
                            Item { Layout.fillHeight: true }
                            Text {
                                Layout.fillWidth: true
                                horizontalAlignment: Text.AlignHCenter
                                color: Theme.colAccent
                                font.pointSize: 10
                                font.bold: true
                                font.family: Theme.fontFamily
                                text: Players.active ? Players.active.trackArtist : ""
                                elide: Text.ElideRight
                            }
                        }
                    }

                    Rectangle {
                        id: albumArt
                        anchors.centerIn: trackInfo
                        color: "transparent"
                        width: trackInfo.width
                        height: 200
                        radius: 15

                        RectangularShadow {
                            anchors.fill: parent
                            anchors.margins: 10
                            color: Theme.colAccent
                            blur: 20
                            spread: -5
                            radius: 15
                        }

                        ClippingRectangle {
                            anchors.fill: parent
                            radius: 15
                            color: "transparent"
                            Image {
                                anchors.fill: parent
                                asynchronous: true
                                fillMode: Image.PreserveAspectCrop
                                source: Players.active?.trackArtUrl || ""
                            }
                        }
                    }

                    ColumnLayout {
                        width: 180
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: trackInfo.bottom
                        anchors.bottom: playerControls.top
                        spacing: 0

                        Slider {
                            id: trackBar
                            Layout.fillWidth: true
                            from: 0
                            to: Players.active ? Players.active.length : 0
                            value: Players.active ? Players.active.position : 0
                            onMoved: { if (Players.active?.canSeek) Players.active.position = value }

                            background: Rectangle {
                                x: trackBar.leftPadding; y: trackBar.topPadding + trackBar.availableHeight / 2 - height / 2
                                implicitHeight: 4; width: trackBar.availableWidth; height: implicitHeight; radius: 2; color: Theme.colBg; opacity: 0.5
                                Rectangle { width: trackBar.visualPosition * parent.width; height: parent.height; color: Theme.colAccent; radius: 2 }
                            }
                            handle: Rectangle {
                                x: trackBar.leftPadding + trackBar.visualPosition * (trackBar.availableWidth - width); y: trackBar.topPadding + trackBar.availableHeight / 2 - height / 2
                                implicitWidth: 10; implicitHeight: 10; radius: 5; color: Theme.colAccent
                            }
                        }
                    }

                    RowLayout {
                        id: playerControls
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 15
                        spacing: 10

                        StyledButton { text: "󰒮"; onClicked: Players.active?.previous() }
                        StyledButton { text: Players.active?.isPlaying ? "" : ""; onClicked: Players.active?.togglePlaying() }
                        StyledButton { text: "󰒭"; onClicked: Players.active?.next() }
                    }
                }
            }
        }
    }
}
